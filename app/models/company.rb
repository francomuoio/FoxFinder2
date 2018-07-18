class Company < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :negociators
  has_many :properties

  has_one :siege_company, :class_name => 'Company', :foreign_key => :siege_id
  accepts_nested_attributes_for :siege_company

  def siege?
   siege_id.nil?
  end

  def sub_company?
   !siege?
  end
end
