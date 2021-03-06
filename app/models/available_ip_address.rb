class AvailableIpAddress < ActiveRecord::Base
  has_one :ip_addr_usage, dependent: :restrict_with_exception

  validates :ip_address, ip_addr: true, presence: true,
                         uniqueness: true

  def <=>(rhs)
    lhs_operand = ip_address.split('.').map { |i| "%3d" % i.to_i }
    rhs_operand = rhs.ip_address.split('.').map { |i| "%3d" % i.to_i }
    lhs_operand <=> rhs_operand
  end

  def AvailableIpAddress.unused
    all.select{ |addr| addr.ip_addr_usage.nil? }
  end
end
