class Transaction < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessor :date

  belongs_to :user
  
end
