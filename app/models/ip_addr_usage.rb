class IpAddrUsage < ActiveRecord::Base
  belongs_to :available_ip_address 
  validates :user, presence: true
  validates :location, presence: true
  validates :available_ip_address_id, presence: true,
                         uniqueness: true
end
