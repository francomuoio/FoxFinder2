class Negociator < ApplicationRecord
  belongs_to :company
  has_many :property

  def full_name
    [first_name, last_name].select(&:present?).join(' ').titleize
  end
end
