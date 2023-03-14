class Group < ApplicationRecord
  belongs_to :user
  has_many :group_clients, dependent: :destroy
  has_many :clients, through: :group_clients, dependent: :destroy
end
