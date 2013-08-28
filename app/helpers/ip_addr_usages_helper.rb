module IpAddrUsagesHelper
  def sort_by_ip_address(ip_addr_usages)
    ip_addr_usages.sort_by do |usage| 
      usage.ip_address.split('.').map { |i| "%3d" % i.to_i } 
    end 
  end
end
