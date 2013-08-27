module ApplicationHelper

  def full_title(page_title)
    base_title = "IPManagement"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def unused_ip_addresses(ip_addresses)
    ans = []
    1.upto(255) do |n|
      ans.push("192.168.15.#{n}")
    end
    
    ip_addresses.each do |ip_address|
      ans.delete(ip_address)
    end

    ans
  end
end
