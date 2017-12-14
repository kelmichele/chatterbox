class Note < ApplicationRecord
	belongs_to :user
  belongs_to :customer_chat

  after_create_commit { NoteBroadcastJob.perform_later(self) }
end
