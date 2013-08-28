class IpAddrUsage < ActiveRecord::Base
  belongs_to :available_ip_address 
  validates :user, presence: true
  validates :location, presence: true
  validates :available_ip_address_id, presence: true,
                         uniqueness: true

  # TODO delete
  validates :ip_address, ip_addr: true, presence: true,
                         uniqueness: true
end
