module ApplicationHelper

  def full_title(page_title)
    base_title = "IPManagement"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def available_ip_addesses(addresses, now_address = nil)
    if now_address
      unused_ip_addresses(addresses).insert(0, now_address)
    else
      unused_ip_addresses(addresses)
    end
  end

  CANDIDATES = ["192.168.15"]
  def unused_ip_addresses(ip_addresses)
    ans = []
    CANDIDATES.each do |candidate|
      1.upto(254) do |n|
        ans.push("#{candidate}.#{n}")
      end
    end
    
    ip_addresses.each do |ip_address|
      ans.delete(ip_address)
    end

    ans
  end
end
