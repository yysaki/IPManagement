module ApplicationHelper

  def full_title(page_title)
    base_title = "IPManagement"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def available_ip_addesses(ip_addresses, now_ip_address = nil)
    if now_ip_address
      unused_ip_addresses(ip_addresses).insert(0, now_ip_address)
    else
      unused_ip_addresses(ip_addresses)
    end
  end

  def unused_ip_addresses(ip_addresses)
    ans = AvailableIpAddress.all.sort.map { |add| add.ip_address }
    
    ip_addresses.each do |ip_address|
      ans.delete(ip_address)
    end

    ans
  end
end
