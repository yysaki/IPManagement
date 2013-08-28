class AvailableIpAddress < ActiveRecord::Base
  has_one :ip_addr_usage, dependent: :restrict_with_exception
end
