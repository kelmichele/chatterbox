class CustomerChat < ApplicationRecord
 	has_many :notes, dependent: :destroy
 	belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
 	belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

 	validates :sender_id, uniqueness: { scope: :recipient_id }

 	scope :between, -> (sender_id, recipient_id) do
 	  where(sender_id: sender_id, recipient_id: recipient_id).or(
 	    where(sender_id: recipient_id, recipient_id: sender_id)
 	  )
 	end

 	def self.get(sender_id, recipient_id)
 	  customer_chat = between(sender_id, recipient_id).first
 	  return customer_chat if customer_chat.present?

 	  create(sender_id: sender_id, recipient_id: recipient_id)
 	end

 	def opposed_user(user)
 	  user == recipient ? sender : recipient
 	end
end
