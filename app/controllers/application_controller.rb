class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def game_creator?(game)
    current_user == game.creator
  end
  helper_method :game_creator?

  def current_creator_has_valid_teams(game)
    current_user && current_user == game.creator && game.valid_teams.count > 0
  end
  helper_method :current_creator_has_valid_teams

end
