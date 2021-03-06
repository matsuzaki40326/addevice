class Review < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :goods, dependent: :destroy


  validates :comment, presence: true, length: { maximum: 400 }
  validates :rate, presence: true

  def good_by?(user)
    goods.exists?(user_id: user.id)
  end
end
