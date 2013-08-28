class AvailableIpAddress < ActiveRecord::Base
  has_one :ip_addr_usage
end
