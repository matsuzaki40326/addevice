class Maker < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :name, presence: true
end
