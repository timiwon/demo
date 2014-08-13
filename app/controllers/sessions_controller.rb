class SessionsController < ApplicationController
	def new
		@arr = (0..7).to_a
		@arr[5]
		@arr.delete(5)

	end

	def create

		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_back_or user
		else
			flash.now[:error] = "Invalid email/password combination"
			render 'new'
		end

		
	end

	def destroy
		sign_out
    	redirect_to root_url
	end
end
