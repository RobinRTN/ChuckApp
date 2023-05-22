class Package < ApplicationRecord
  belongs_to :user
  has_many :formules
  accepts_nested_attributes_for :formules, allow_destroy: true

  validates :name, presence: true


end
