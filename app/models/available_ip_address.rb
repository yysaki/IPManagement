class AvailableIpAddress < ActiveRecord::Base
  has_one :ip_addr_usage, dependent: :restrict_with_exception

  validates :ip_address, ip_addr: true, presence: true,
                         uniqueness: true

 attr_accessor :ip_address_str, :ip_address_lb, :ip_address_ub 
end
