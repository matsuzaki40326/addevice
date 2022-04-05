class Review < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :comment, presence: { message: 'を入力してください' }
  validates :rate, presence: true
end
