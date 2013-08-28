namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    1.upto(254) do |n|
      AvailableIpAddress.create!(ip_address: "192.168.15.#{n}")
    end

    IpAddrUsage.create!(
      ip_address: "192.168.15.1", user: "osol", location: "実機", 
      note: "vm1.websys.timedia.co.jp # in websys server room",
      available_ip_address_id: 1)

    70.times do |n|
      ip_address = "192.168.15.#{n*3+2}"
      user = Faker::Name.name
      machine_name = "vm#{n*3+2}"
      location = "vm#{n*3+2}"
      available_ip_address_id = n*3+2
      IpAddrUsage.create!(
        ip_address: ip_address, user: user,
        machine_name: machine_name, location: location,
        available_ip_address_id: available_ip_address_id)

    end
  end
end
