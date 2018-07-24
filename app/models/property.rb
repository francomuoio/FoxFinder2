class Property < ApplicationRecord
validates :property_type, presence: true
validates :property_nbr, presence: true
validates :mandat_type, presence: true
validates :mandat_date, presence: true
validates :compromis_date, presence: true
validates :address, presence: true
validates :price, presence: true
validates :negociator_id, presence: true
validates :company_id, presence: true

has_one :negociator
belongs_to :company

geocoded_by :address
after_validation :geocode
end
