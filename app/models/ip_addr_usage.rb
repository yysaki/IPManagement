class IpAddrUsage < ActiveRecord::Base
  belongs_to :available_ip_address 
  validates :ip_address, ip_addr: true, presence: true,
                         uniqueness: true
  validates :user, presence: true
  validates :location, presence: true
end
