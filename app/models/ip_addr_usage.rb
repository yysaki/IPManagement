class IpAddrUsage < ActiveRecord::Base
  validates :ip_address, ip_addr: true, presence: true,
                         uniqueness: true
  validates :user, presence: true
  validates :location, presence: true
end
