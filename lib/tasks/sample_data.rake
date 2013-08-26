namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    IpAddrUsage.create!(ip_address: "192.168.15.0", user: "osol", 
                 location: "実機", note: "vm1.websys.timedia.co.jp # in websys server room")
    200.times do |n|
      ip_address = "192.168.15.#{n+1}"
      user = Faker::Name.name
      machine_name = "vm#{n+1}"
      location = "vm#{n+1}"
      IpAddrUsage.create!(ip_address: ip_address, user: user,
                   machine_name: machine_name, location: location)
    end
  end
end
