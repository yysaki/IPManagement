class AddColumnToIpAddrUsageAvailableIpAddressId < ActiveRecord::Migration
  def change
    add_column :ip_addr_usages, :available_ip_address_id, :integer
  end
end
