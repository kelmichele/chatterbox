class CustomerChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "customer_chats-#{current_or_guest_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end

  def speak(data)
    note_params = data['note'].each_with_object({}) do |el, hash|
      hash[el.values.first] = el.values.last
    end

    Note.create(note_params)
  end
end
