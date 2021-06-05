class RulesChannel < ApplicationCable::Channel
  def subscribed
    # stream_from rules channel based on device group
    stream_from "rules_#{params[:device_group_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
