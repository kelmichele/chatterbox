class CustomerChatsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create]

  def create
    @customer_chat = CustomerChat.get(current_or_guest_user.id, params[:user_id])

    add_to_customer_chats unless chatted?
    respond_to do |format|
      format.js
    end
  end

  def close
    @customer_chat = CustomerChat.find(params[:id])

    session[:customer_chats].delete(@customer_chat.id)
    respond_to do |format|
      format.js
    end
  end

  private

  def add_to_customer_chats
    session[:customer_chats] ||= []
    session[:customer_chats] << @customer_chat.id
  end

  def chatted?
    session[:customer_chats].include?(@customer_chat.id)
  end
end
