class Contact < ApplicationRecord
  def friendly_updated_at
    updated_at.strftime("%b%e, %Y,%l:%M %p")
  end

  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end
end
