class AddIndexToIpAddrUsageAvailableIpAddressId < ActiveRecord::Migration
  def change
    add_index :ip_addr_usages, :available_ip_address_id, unique: true
  end
end
