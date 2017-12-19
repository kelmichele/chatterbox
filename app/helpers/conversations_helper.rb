module ConversationsHelper
	def conv_recipient(conversation)
    conversation.opposed_user(current_or_guest_user)
  end
end
