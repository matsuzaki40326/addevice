class Review < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :goods

  validates :comment, presence: { message: 'を入力してください' }
  validates :rate, presence: true

  def good_by?(user)
    goods.exists?(user_id: user.id)
  end
end
