use iota_streams::{
  app::message::HasLink,
  app_channels::api::{
      psk_from_seed,
      pskid_from_psk,
      tangle::{
          Author,
          ChannelType,
          Subscriber,
          Transport,
      }
  },
  core::{
      panic_if_not,
      prelude::HashMap,
      print,
      println,
      try_or,
      Errors::*,
      Result,
  },
  ddml::types::*,
};

use super::utils;

pub async fn example<T: Transport>(transport: T, channel_impl: ChannelType, seed: &str) -> Result<()> {
  let mut author = Author::new(seed, channel_impl, transport.clone());
  // println!("Author multi branching?: {}", author.is_multi_branching());

  let mut subscriberA = Subscriber::new("SUBSCRIBERA9SEED", transport.clone());
  let mut subscriberB = Subscriber::new("SUBSCRIBERB9SEED", transport.clone());
  let mut subscriberC = Subscriber::new("SUBSCRIBERC9SEED", transport);

  let public_payload = Bytes("PUBLICPAYLOAD".as_bytes().to_vec());
  let masked_payload = Bytes("MASKEDPAYLOAD".as_bytes().to_vec());

  // println!("\nAnnounce Channel");
  println!("\nAnunciamento de canal");
  let announcement_link = {
      let msg = author.send_announce().await?;
      // println!("  msg => <{}> <{:x}>", msg.msgid, msg.to_msg_index());
      // print!("  Author     : {}", author);
      msg
  };
  // println!("  Author channel address: {}", author.channel_address().unwrap());
  println!("  Endereço do canal do autor: {}", author.channel_address().unwrap());

  // println!("\nHandle Announce Channel");
  println!("\nProcessar anúncio de canal");

  {
      subscriberA.receive_announcement(&announcement_link).await?;
      // print!("  SubscriberA: {}", subscriberA);
      print!("  Assinante A: {}", subscriberA);
      try_or!(
          author.channel_address() == subscriberA.channel_address(),
          ApplicationInstanceMismatch(String::from("A"))
      )?;
      subscriberB.receive_announcement(&announcement_link).await?;
      // print!("  SubscriberB: {}", subscriberB);
      print!("  Assinante B: {}", subscriberB);
      try_or!(
          author.channel_address() == subscriberB.channel_address(),
          ApplicationInstanceMismatch(String::from("B"))
      )?;
      subscriberC.receive_announcement(&announcement_link).await?;
      // print!("  SubscriberC: {}", subscriberC);
      // print!("  Assinante C: {}", subscriberC);
      try_or!(
          author.channel_address() == subscriberC.channel_address(),
          ApplicationInstanceMismatch(String::from("C"))
      )?;

      try_or!(
          subscriberA
              .channel_address()
              .map_or(false, |appinst| appinst == announcement_link.base()),
          ApplicationInstanceMismatch(String::from("A"))
      )?;
      try_or!(
          subscriberA.is_multi_branching() == author.is_multi_branching(),
          BranchingFlagMismatch(String::from("A"))
      )?;
  }

  // println!("\nSubscribe A");
  println!("\nIngressar assinante A");

  let subscribeA_link = {
      let msg = subscriberA.send_subscribe(&announcement_link).await?;
      // println!("  msg => <{}> <{:x}>", msg.msgid, msg.to_msg_index());
      // print!("  SubscriberA: {}", subscriberA);
      print!("  Assinante A: {}", subscriberA);

      msg
  };

  // println!("\nHandle Subscribe A");
  println!("\nVerificar Assinante A ");
  {
      author.receive_subscribe(&subscribeA_link).await?;
      // print!("  Author     : {}", author);
      print!("  Autor     : {}", author);
  }

  // println!("\nSubscribe B");
  println!("\nIngressar Assinante B ");
  let subscribeB_link = {
      let msg = subscriberB.send_subscribe(&announcement_link).await?;
      // println!("  msg => <{}> <{:x}>", msg.msgid, msg.to_msg_index());
      // print!("  SubscriberB: {}", subscriberB);
      print!("  Assinante B: {}", subscriberB);

      msg
  };

  // println!("\nHandle Subscribe B");
  println!("\nVerificar Assinante B ");
  {
      author.receive_subscribe(&subscribeB_link).await?;
      // print!("  Author     : {}", author);
      print!("  Autor     : {}", author);
  }

  // println!("\nSubscribe C");
  // let subscribeC_link = {
  //     let msg = subscriberC.send_subscribe(&announcement_link).await?;
  //     println!("  msg => <{}> <{:x}>", msg.msgid, msg.to_msg_index());
  //     print!("  SubscriberC: {}", subscriberC);
  //     msg
  // };

  // println!("\nHandle Subscribe C");
  // {
  //     author.receive_subscribe(&subscribeC_link).await?;
  //     print!("  Author     : {}", author);
  // }

  // println!("\nShare keyload for everyone [SubscriberA, SubscriberB, SubscriberC]");
  println!("\nCompartilhar keyload [Assinante A, Assinante B]");

  let previous_msg_link = {
      let (msg, seq) = author.send_keyload_for_everyone(&announcement_link).await?;
      // println!("  msg => <{}> <{:x}>", msg.msgid, msg.to_msg_index());
      panic_if_not(seq.is_none());
      // print!("  Author     : {}", author);
      msg
  };

  // println!("\nHandle Keyload");
  println!("\nVerificar Keyload");
  {
      subscriberA.receive_keyload(&previous_msg_link).await?;
      print!("  Keyload Assinante A: {}", subscriberA);
      subscriberB.receive_keyload(&previous_msg_link).await?;
      // print!("  Assinante B: {}", subscriberB);
      subscriberC.receive_keyload(&previous_msg_link).await?;
      // print!("  Assinante C: {}", subscriberC);
  }

  // println!("\nSigned packet");
  println!("\nAutor envia mensagem criptografada");
  let previous_msg_link = {
      let (msg, seq) = author.send_signed_packet(&previous_msg_link, &public_payload, &masked_payload).await?;
      // println!("  msg => <{}> <{:x}>", msg.msgid, msg.to_msg_index());
      panic_if_not(seq.is_none());
      print!("  Mensagem criptografada     : {}", masked_payload);
      msg
  };

  // println!("\nHandle Signed packet");
  println!("\nVerificar mensagem criptografada no Assinante A");
  {
      let (_signer_pk, unwrapped_public, unwrapped_masked) = subscriberA.receive_signed_packet(&previous_msg_link).await?;
      // print!("  Assinante A: {}", subscriberA);
      // print!("     PublicPayload     : {}", unwrapped_public.to_string());
      print!("     Mensagem criptografada recebida é igual à enviada     : {}", public_payload == unwrapped_public);
      print!("\n");

      try_or!(
          public_payload == unwrapped_public,
          PublicPayloadMismatch(public_payload.to_string(), unwrapped_public.to_string())
      )?;
      try_or!(
          masked_payload == unwrapped_masked,
          PublicPayloadMismatch(masked_payload.to_string(), unwrapped_masked.to_string())
      )?;
  }

  // println!("\nSubscriber A fetching transactions...");
  // utils::s_fetch_next_messages(&mut subscriberA).await;
  // println!("\nSubscriber C fetching transactions...");
  // utils::s_fetch_next_messages(&mut subscriberC).await;

  // println!("\nSubscriber B fetching transactions...");
  // utils::s_fetch_next_messages(&mut subscriberB).await;
  // println!("\nSubscriber C fetching transactions...");
  // utils::s_fetch_next_messages(&mut subscriberC).await;

  Ok(())
}
