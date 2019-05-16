class Contact < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :email, presence: true
  validates :email, uniqueness: true
  # validates :email, format: {with: /\A\w+[@]\w{3,}[.]w{2,}\z/, message: "must be a valid email format"}

  validates :phone_number, presence: true

  # validates :bio, presence: true
  # validates :bio, length: {in: 50..200}

  belongs_to :user

  def friendly_updated_at
    updated_at.strftime("%b%e, %Y,%l:%M %p %Z")
  end

  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end
end
