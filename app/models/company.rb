class Company < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:free_company, :premium_company, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :free_company
  end

  has_many :negociators
  has_many :properties

end
