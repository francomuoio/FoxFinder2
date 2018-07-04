class Property < ApplicationRecord
validates :property_type, presence: true
validates :property_nbr, presence: true
validates :property_date, presence: true
validates :mandat_type, presence: true
validates :mandat_date, presence: true
validates :compromis_date, presence: true
validates :address, presence: true
validates :price, presence: true
validates :negociators_id, presence: true
validates :companies_id, presence: true

end
