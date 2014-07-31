namespace :my_tasks do
  desc "Add ewingers to the site's database."
  task :add_ewingers => :environment do
  	ewingers = ["Genji","Malde","B2","DD","Bro","Gatu","Sparta","DC","DIBU","SIR","Jaylu","Azazel","Radhe","Price","Scorp"]

  	ewingers.each do |ewinger|
  		user = User.new
  		user.name = ewinger
  		user.password = ewinger + "12az"
  		user.save
  	end
  end

end
