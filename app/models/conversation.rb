class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

  validates :sender_id, uniqueness: { scope: :recipient_id }

  scope :between, -> (sender_id, recipient_id) do
    where(sender_id: sender_id, recipient_id: recipient_id).or(
      where(sender_id: recipient_id, recipient_id: sender_id)
    )
  end

  def self.get(sender_id, recipient_id)
    conversation = between(sender_id, recipient_id).first
    return conversation if conversation.present?

    create(sender_id: sender_id, recipient_id: recipient_id)
  end

  def opposed_user(user)
    user == recipient ? sender : recipient
  end

  def open_tickets
  end

end


# def ensure_admin
#   raise Discourse::InvalidAccess.new unless current_user && current_user.admin?
# end

# def username_is_allowed
#   if FORBIDDEN_USERNAMES.include?(username)
#     errors.add(:username, "has been restricted from use.")
#   end
# end

# def no_new_users_on_monday
#   if Time.now.wday == 1
#     errors.add(:base, "No new users on Mondays.")
#   end
# end
