class AccessController < ApplicationController
  
  layout 'header'

  def new
    @user = User.new
    render "register"    
  end

  def create
    hash = params[:user]
    @user = User.new
    @user.name = hash[:name]
    @user.password = hash[:password]

    if @user.save
      logger.info "Save Successfull."
      session[:user_id] = @user.id
      session[:name] = @user.name
      flash[:notice] = "Login Successfull."
      redirect_to(:controller => 'hisab', :action => 'index')
    else
      logger.info "Save Failed."
      render "register"
    end
  end

  def login
  	render 'login'
  end

  def attempt_login
  	hash = params[:user]
  	current_user = User.authenticate_user(hash[:name], hash[:password])
  	if current_user
  		session[:user_id] = current_user.id
  		session[:name] = current_user.name
  		flash[:notice] = "Login Successfull."
  		redirect_to(:controller => 'hisab', :action => 'index')
  	else
  		flash[:notice] = "Invalid input. Login failed."
  		redirect_to(:action => 'login')  		
  	end
  end

  def logout
		session[:user_id] = nil
		session[:name] = nil
		flash[:notice] = "Logged out successfully."
		redirect_to(:action => "login")
	end

  def change_password_form
  end

  def change_password
    
    current_user = User.authenticate_user(session[:name], params[:old_pwd])

    if current_user
      current_user.password = params[:new_pwd]
      if current_user.save
        redirect_to ('/')
      else
        flash[:notice] = "Changing password failed. Please try again later."
        redirect_to ('/access/change_password_form')
      end
    else
      flash[:notice] = "Current password is incorrect."
      redirect_to ('/access/change_password_form')
    end
  end
end
