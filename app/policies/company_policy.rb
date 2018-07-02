class CompanyPolicy < ApplicationPolicy
  def new?
    @company.admin?
  end
  def show?
  end
  class Scope < Scope
    def resolve
      scope
    end
  end
end
