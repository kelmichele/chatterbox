class NoteBroadcastJob < ApplicationJob
  queue_as :default

  def perform(note)
    sender = note.user
    recipient = note.customer_chat.opposed_user(sender)

    broadcast_to_sender(sender, note)
    broadcast_to_recipient(recipient, note)
  end

  private

  def broadcast_to_sender(user, note)
    ActionCable.server.broadcast(
      "customer_chats-#{user.id}",
      note: render_note(note, user),
      customer_chat_id: note.customer_chat_id
    )
  end

  def broadcast_to_recipient(user, note)
    ActionCable.server.broadcast(
      "customer_chats-#{user.id}",
      window: render_window(note.customer_chat, user),
      note: render_note(note, user),
      customer_chat_id: note.customer_chat_id
    )
  end

  def render_note(note, user)
    ApplicationController.render(
      partial: 'notes/note',
      locals: { note: note, user: user }
    )
  end

  def render_window(customer_chat, user)
    ApplicationController.render(
      partial: 'customer_chats/customer_chat',
      locals: { customer_chat: customer_chat, user: user }
    )
  end
end
