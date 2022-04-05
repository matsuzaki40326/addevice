class Item < ApplicationRecord
  has_one_attached :image

  validates :name, presence: true
  validates :image, presence: true

  has_many :favorites, dependent: :destroy  
  has_many :reviews, dependent: :destroy


  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.looks(search, word)
    @item = Item.where("name LIKE?", "%#{word}%")
  end
end
