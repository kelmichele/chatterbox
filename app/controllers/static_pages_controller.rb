class StaticPagesController < ApplicationController

	def chatroom
		session[:conversations] ||= []

    @users = User.all.where.not(id: current_or_guest_user)
    @conversations = Conversation.includes(:recipient, :messages)
                                 .find(session[:conversations])
	end

	def support
		session[:customer_chats] ||= []

    @users = User.all.where.not(id: current_or_guest_user)
    @customer_chats = CustomerChat.includes(:recipient, :notes)
                                 		.find(session[:customer_chats])
	end
end
