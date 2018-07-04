class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  private

  def current_ability
    @current_ability ||= Ability.new(current_user || current_company)
  end
    protected
end
