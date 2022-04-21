class Review < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :goods

  validates :comment, presence: true, length: { maximum: 1000 }
  validates :rate, presence: true

  def good_by?(user)
    goods.exists?(user_id: user.id)
  end
end
