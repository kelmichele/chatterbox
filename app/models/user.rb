class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :messages
  has_many :conversations, foreign_key: :sender_id

  has_many :notes
  has_many :customer_chats, foreign_key: :sender_id

  def name
  	email.split('@')[0]
	end
end
