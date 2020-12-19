class MessagesController < ApplicationController
  def create
    service = MessagesService.new(message_params)
    service.create
    json_response service
  end

  def like
    service = MessagesService.new(like_params)
    service.like
    json_response service
  end

  def top_messages
    service = MessagesService.new(top_messages_params)
    service.top_messages
    json_response service
  end

  private

  def message_params
    params.permit(:author, :message)
  end

  def like_params
    params.permit(:message_id).merge(ip_address: request.remote_ip)
  end

  def top_messages_params
    params.permit(:period)
  end
end