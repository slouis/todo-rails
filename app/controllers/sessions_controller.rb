class SessionsController < ApplicationController
  
  def new
      render "new", :layout => "welcome"
  end  
    
  def create  
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash.now.alert = "Invalid email or password"
      render "new", :layout => "welcome"
    end
  end

  def destroy  
	  session[:user_id] = nil  
  	redirect_to root_url, :notice => "Logged out!"  
  end  

end
