class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  protect_from_forgery with: :exception

  private

  def current_date
    @current_date ||= params[:date]&.to_date || Date.current
  end
  helper_method :current_date
end
