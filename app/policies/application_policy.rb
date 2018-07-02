class ApplicationPolicy
  attr_reader :company, :record

  def initialize(company, record)
    @company = company
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(company, record.class)
  end

  class Scope
    attr_reader :company, :scope

    def initialize(company, scope)
      @company = company
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
