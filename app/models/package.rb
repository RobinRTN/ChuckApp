class Package < ApplicationRecord
  belongs_to :user
  has_many :formules
end
