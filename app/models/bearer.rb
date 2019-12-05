class Bearer < ApplicationRecord
  has_many :stocks, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
