class AccountController < ApplicationController

	def change_password
   		@user = current_user
		if request.post?
			existing_password         = params[:existing_password]
			new_password              = params[:new_password]
			new_password_confirmation = params[:new_password_confirmation]

			if @user.password_hash != BCrypt::Engine.hash_secret(existing_password, @user.password_salt)
				@user.errors.add("Current password", "didn't match")
			end
			if new_password == ""
				@user.errors.add("New password", "can't be blank")
			end
			if new_password != new_password_confirmation
				@user.errors.add("Password", "doesn't match confirmation")
			end
			if @user.errors.any?
				render :action => "change_password"
			else
			  @user.password_hash = BCrypt::Engine.hash_secret(new_password, @user.password_salt)
		      if @user.save
		        redirect_to root_url
		      end
		    end
	    else
	    	p "get !"
	    end
	end

	def change_email
		@user = current_user
		if request.post?
			if params[:user][:new_email] == ""
				@user.errors.add("New email", "can't be blank")
			end
			if params[:user][:new_email] != params[:user][:new_email_confirmation]
				@user.errors.add("Email", "doesn't match confirmation")
			end
			user = User.find_by_email(params[:user][:new_email])
			if user != nil
				@user.errors.add("Email", "has already been taken")
			end

			if @user.errors.any?
				render :action => "change_email"
			else
				@user.email = params[:user][:new_email]
		    	if @user.save
		        	redirect_to root_url
		      	end
		    end
	    else
	    	render "change_email"
	    end
	end

	def cancel_account
		@user = current_user
    	@user.destroy
    	session[:user_id] = nil  
	    respond_to do |format|
    		format.html { redirect_to root_url }
	    	format.json { head :no_content }
	    end
	end

end
