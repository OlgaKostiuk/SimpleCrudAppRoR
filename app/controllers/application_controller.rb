class ApplicationController < ActionController::Base
  before_action  :set_locale, :authenticate_user!
  protect_from_forgery with: :exception

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
