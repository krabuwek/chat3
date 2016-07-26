module Rooms
  class MessagesController < ApplicationController
    before_action :set_message, only: [:show, :edit, :update, :destroy]
    include RoomCommonMethods

    def index
      @messages = @room.messages
    end

    def create
      @message = Message.new(message_params)
      @message.user_id = current_user.id
      @message.room_id = params[:room_id]
      if @message.save
        redirect_to room_messages_path @room
      else
        redirect_to room_messages_path @room, notice: "failed to send message"
      end
    end

    private
      def set_message
        @message = Message.find(id: params[:id])
      end

      def message_params
        params.require(:message).permit(:id, :text)
      end
  end
end