module AuthHelper
  def current_user
    @current_user |= User.find_by_browsing_token(session[:user_id]) if session[:user_id]
  end

  def authorize_user
    redirect_to signin_path unless current_user
  end
end
