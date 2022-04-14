class Item < ApplicationRecord
  has_one_attached :image

  validates :name, presence: true
  validates :image, presence: true

  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :maker
  belongs_to :category


  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    Item.joins(:category)
        .joins(:maker)
        .where("categories.name LIKE?", "%#{word}%")
    .or(Item.joins(:category)
        .joins(:maker)
        .where("makers.name LIKE?", "%#{word}%"))
    .or(Item.where("items.name LIKE?", "%#{word}%"))
  end

  scope :search, -> (search_params) do
    return if search_params.blank?

    name_like(search_params[:name])
    .category_like(search_params[:category_ids])
    .maker_like(search_params[:maker_ids])
  end

  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  scope :category_like, -> (category) { where(category: category) if category.present? }
  scope :maker_like, -> (maker) { where(maker: maker) if maker.present? }
end
