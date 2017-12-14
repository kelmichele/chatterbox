class StaticPagesController < ApplicationController
	# skip_before_action :verify_authenticity_token, :only => [:chatroom]

	def chatroom
		session[:conversations] ||= []

    @users = User.all.where.not(id: current_or_guest_user)
    @conversations = Conversation.includes(:recipient, :messages)
                                 .find(session[:conversations])
	end

	def support
		session[:customer_chats] ||= []

    # @users = User.all.where.not(id: current_user)
    @customer_chats = CustomerChat.includes(:boss_admin, :notes)
                                 .find(session[:customer_chats])
	end
end