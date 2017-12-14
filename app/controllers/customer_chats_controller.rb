class CustomerChatsController < ApplicationController
	def create
	  @customer_chat = customer_chat.get(current_user.id, params[:user_id])

	  # add_to_customer_chats unless conversated?
	  respond_to do |format|
	    format.js
	  end
	end

	def close
	  @customer_chat = customer_chat.find(params[:id])

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

	# def conversated?
	#   session[:customer_chats].include?(@customer_chat.id)
	# end
end

