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

  # ping到達不能を示す閾値
  THRESHOLD = 7
  def IpAddrUsage.all_of_unreachable
    IpAddrUsage.all.select {|usage| usage.failed_ping_history >= THRESHOLD }
  end
end
