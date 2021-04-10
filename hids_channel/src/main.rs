#![cfg_attr(debug_assertions, allow(dead_code, unused_imports))]

use dotenv;
use std::env;
mod api_author;

use crate::api_author::announce::start_a_new_channel;
use crate::api_author::get_subscribers::get_subscriptions_and_share_keyload;
use crate::api_author::send_masked_payload::send_masked_payload;
use crate::api_author::send_message::send_signed_message;

use iota_streams::app_channels::api::tangle::Author;

use iota_streams::{
    app::transport::{
        tangle::{
            client::{Client, SendTrytesOptions},
            PAYLOAD_BYTES,
        },
        TransportOptions,
    },
    app_channels::api::tangle::Transport,
    core::{
        prelude::{Rc, String},
        Result,
    },
};

use std::cell::RefCell;

// use iota_streams::app::{
//     transport::tangle::{
//         PAYLOAD_BYTES,
//         client:: {
//             Client,
//             SendTrytesOptions
//         }
//     }
// };

use iota_conversion::trytes_converter::{to_string, to_trytes};

fn main() {
    // Load or .env file, log message if we failed
    if dotenv::dotenv().is_err() {
        println!(".env file not found; copy and rename example.env to \".env\"");
    };

    // Change the default settings to use a lower minimum weight magnitude for the Devnet
    let mut send_opt = SendTrytesOptions::default();
    // default is 14
    send_opt.min_weight_magnitude = 9;
    send_opt.local_pow = false;

    // Parse env vars with a fallback
    let node_url = env::var("URL").unwrap_or("http://localhost:14265".to_string());
    // Fails at unwrap when the url isnt working

    let client = Client::new_from_url(&node_url);

    let mut transport = Rc::new(RefCell::new(client));
    let mut send_opt = SendTrytesOptions::default();
    send_opt.min_weight_magnitude = 9;
    transport.set_send_options(send_opt);
    let encoding = "utf-8";

    // --------------- Author -------------------

    // Create a new channel
    // REPLACE THE SECRET WITH YOUR OWN
    let multi_branching_flag = false;
    let mut author = Author::new(
        "MYAUTHORSEC9ETSTRINGAPWOQ9",
        encoding,
        PAYLOAD_BYTES,
        multi_branching_flag,
        transport.clone(),
    );

    let channel_address = author.channel_address().unwrap().to_string();
    // announce_message is a link, thus it contains the channel address (appinst) and message identifier (msgid)
    let announce_message = start_a_new_channel(&mut author).unwrap();
    let announce_msgid = announce_message.msgid.to_string();

    let public_payload = "BREAKINGCHANGES";

    // signed_message is a link, thus it contains the channel address (appinst) and message identifier (msgid)
    let signed_message = send_signed_message(
        &mut author,
        &channel_address,
        &announce_msgid,
        &public_payload.to_string(),
    )
    .unwrap();
    println!("");
    println!("Now, in a new terminal window, use the subscriber to publish a `Subscribe` message on the channel");
    println!("");
    println!(
        "cargo run --release --bin subscriber {} {} {}",
        channel_address, announce_msgid, signed_message.msgid
    );

    println!("Tangle Address/channel: {}", channel_address);
    println!("Tangle announce_message tag: {}", announce_message);
    println!("Tangle signed_message tag: {}", announce_msgid);

    let mut subscribe_message_identifier = String::new();
    println!("Enter the message identifier of the `Subscribe` message that was published by the subscriber:");
    std::io::stdin()
        .read_line(&mut subscribe_message_identifier)
        .unwrap();

    if subscribe_message_identifier.ends_with('\n') {
        subscribe_message_identifier.pop();
    }
    if subscribe_message_identifier.ends_with('\r') {
        subscribe_message_identifier.pop();
    }

    let keyload_message = get_subscriptions_and_share_keyload(
        &mut author,
        &channel_address,
        &mut subscribe_message_identifier,
    )
    .unwrap();

    println!(
        "Paste this `Keyload` message identifier in the subscriber's command prompt: {}",
        keyload_message.msgid
    );

    let masked_payload = "SUPERSECRETPAYLOAD";

    let signed_private_message = send_masked_payload(
        &mut author,
        &channel_address,
        &keyload_message.msgid.to_string(),
        &public_payload.to_string(),
        &masked_payload.to_string(),
    )
    .unwrap();

    println!(
        "Paste this `SignedPacket` message identifier in the subscriber's command prompt: {}",
        signed_private_message.msgid
    );
}
