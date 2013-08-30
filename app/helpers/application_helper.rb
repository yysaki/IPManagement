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
    ans = AvailableIpAddress.all.sort.map { |add| add.ip_address }
    ip_addresses.each do |ip_address|
      ans.delete(ip_address)
    end
    ans
  end
end
