class Item < ApplicationRecord
  has_one_attached :image

  validates :name, presence: true
  validates :image, presence: true

  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :maker
  belongs_to :category

  attr_accessor :average
  attr_accessor :amount


  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


  def review_rate_average
    if reviews
      reviews.average(:rate).to_f.round(1)
    else
      0.0
    end
  end

  def review_amount
    if reviews
      reviews.count
    else
      0.0
    end
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
