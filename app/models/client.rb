class Client < ApplicationRecord
  validates :first_name, :last_name, presence: true
  validates :phone_number, presence: true, format: { with: /\A(\+33|0)[67]\d{8}\z/, message: "Merci d'entrer un numéro de téléphone au bon format" }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_validation :set_full_name
  before_validation :split_full_name, if: -> { full_name.present? && (first_name.blank? || last_name.blank?) }

  belongs_to :user
  has_many :group_clients, dependent: :destroy
  has_many :groups, through: :group_clients
  has_many :bookings, autosave: true, dependent: :destroy
  has_one_attached :photo

  private

  def set_full_name
    self.full_name = "#{first_name} #{last_name}" if first_name.present? && last_name.present?
  end

  def split_full_name
    name_parts = full_name.split(' ')
    self.first_name = name_parts.shift
    self.last_name = name_parts.join(' ')
  end

end
