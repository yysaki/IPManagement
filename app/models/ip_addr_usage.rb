class IpAddrUsage < ActiveRecord::Base
  belongs_to :available_ip_address 
  validates :user, presence: true
  validates :location, presence: true
  validates :available_ip_address_id, presence: true,
                         uniqueness: true

  attr_accessor :ip_address_str
  def ip_address
    self.available_ip_address.ip_address 
  end

  def <=>(rhs)
    available_ip_address <=> rhs.available_ip_address
  end

end
