class CustomerChat < ApplicationRecord
  has_many :notes, dependent: :destroy
  belongs_to :boss_admin, class_name: 'User'

end
