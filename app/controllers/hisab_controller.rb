class HisabController < ApplicationController
  
  layout 'header'
  
  def index
  	#}) #:lender == session[:name] OR :receiver == session[:name]})
  	#@transactions += Transaction.where({:receiver => session[:name]})
  	#@transactions.order(updated_at: :desc)
  	@users = User.all

  	render "index"
  end

  def get_transactions
  	if session[:name].blank?
  			redirect_to ('/access/login')
  	else
  		@transactions = Transaction.where("lender = '#{session[:name]}' OR receiver = '#{session[:name]}'").order("updated_at DESC")

  		render "get_transactions"
  	end
  	
  end

  def add_entry

  		if session[:name].blank?
  			redirect_to ('/access/login') 
  		else
  			@transaction = Transaction.new
  			@members = User.all_except

  			render "add_entry"
  		end
  end

  def create_entry
  	hash = params[:transaction]
  	@transaction = Transaction.new
  	@transaction.lender = session[:name]
  	@transaction.receiver = hash[:receiver]
  	@transaction.amount = hash[:amount]
  	@transaction.details = hash[:details]
  	#@transaction.date  = "#{hash["date(1i)"]}-#{hash["date(2i)"]}-#{hash["date(3i)"]}
  	 
  	if @transaction.save
  		redirect_to ('/')
  	else
  		logger.info "Error saving transaction."
  	end
  end
end
