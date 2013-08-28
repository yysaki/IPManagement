class RemoveIpAddressFromIpAddrUsages < ActiveRecord::Migration
  def change
     remove_column :ip_addr_usages, :ip_address
  end
end
