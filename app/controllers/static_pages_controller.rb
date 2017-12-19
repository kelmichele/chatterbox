class StaticPagesController < ApplicationController

	def chatroom
		session[:conversations] ||= []

    @conversations = Conversation.includes(:recipient, :messages)
                                 .find(session[:conversations])

    if current_or_guest_user.admin?
	    @users = User.all.where.not(id: current_or_guest_user)
	  else
	    @users = User.where(admin: true)
    end
	end

	def admin_chat
		session[:conversations] ||= []

    @conversations = Conversation.includes(:recipient, :messages)
                                 .find(session[:conversations])

    if current_or_guest_user.admin?
	    @users = User.all.where.not(id: current_or_guest_user)
	  else
	    @users = User.all.where(admin: true)
    end

    @closed_line = Conversation.where('created_at >= ?', Time.now-3.days)
    @open_line = Conversation.where('created_at <= ?', Time.now-3.days)
	end

	def support
		session[:customer_chats] ||= []

    @users = User.all.where.not(id: current_or_guest_user)
    @customer_chats = CustomerChat.includes(:recipient, :notes)
                                 		.find(session[:customer_chats])
	end
end
