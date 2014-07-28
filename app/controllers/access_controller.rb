class AccessController < ApplicationController
  
  layout 'header'

  def login
  	render 'login'
  end

  def attempt_login
  	hash = params[:user]
  	current_user = User.authenticate_user(hash[:name], hash[:password])
  	if current_user
  		session[:user_id] = current_user.user_id
  		session[:name] = current_user.name
  		flash[:notice] = "Login Successfull."
  		redirect_to(:controller => 'hisab', :action => 'index')
  	else
  		flash[:notice] = "Login failed try again."
  		redirect_to(:action => 'login')  		
  	end
  end

  def logout
		session[:user_id] = nil
		session[:name] = nil
		flash[:notice] = "Logged out successfully."
		redirect_to(:action => "login")
	end
end
