class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user  
  before_filter :authenticate, :unless => :login?

  private  

  def current_user  
    @current_user ||= User.find(session[:user_id]) if session[:user_id]  
  end

  def authenticate
	if current_user == nil
    	redirect_to :controller => 'sessions', :action => 'new'
    end
  end

  def login?
  	self.controller_name == 'sessions' || self.controller_name == 'users'
  end
end
