class Company < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :negociators
  has_many :properties

  has_one :siege_company, class_name: 'Company', foreign_key: :siege_id
  accepts_nested_attributes_for :siege_company
  accepts_nested_attributes_for :properties, allow_destroy: true
  accepts_nested_attributes_for :negociators, allow_destroy: true
end
