class AccountController < ApplicationController

	def change_password
		if request.post?
			existing_password         = params[:existing_password]
			new_password              = params[:new_password]
			new_password_confirmation = params[:new_password_confirmation]

			if current_user.password_hash == BCrypt::Engine.hash_secret(existing_password, current_user.password_salt)
				p "OKKKKKKKKKKKKKKKKKK"
				
			else
				p "NGGGGGGGGGGGGGGGGGG"
			end
	    else
	    	p "get !"
	    end
	end

	def change_email
		logger.info("email")
	end

end
