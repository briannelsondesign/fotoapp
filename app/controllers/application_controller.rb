class ApplicationController < ActionController::Base

  protect_from_forgery
  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?

  private

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue Exception => e
      nil
    end
  end

  def user_signed_in?
    return true if current_user
  end

  def correct_user?
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to root_url, :alert => "Access denied."
    end
  end

  def authenticate_user!
    if !current_user
      redirect_to root_url, :alert => 'You need to sign in for access to this page.'
    end
  end

  # Internal: PhotoStore required for current user.
  def photo_store_required!
    if !current_photo_store
      redirect_to account_path, :alert => "You need to configure S3 for your account."
    end
  end

  # Internal: The photo store for the current user if it exists.
  #
  # Returns a PhotoStore or nil.
  def current_photo_store
    current_user.photo_store
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
end
