class AvailableIpAddress < ActiveRecord::Base
  has_one :ip_addr_usage, dependent: :restrict_with_exception

  validates :ip_address, ip_addr: true, presence: true,
                         uniqueness: true
end
