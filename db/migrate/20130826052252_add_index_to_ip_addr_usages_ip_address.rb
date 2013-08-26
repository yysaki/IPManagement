class AddIndexToIpAddrUsagesIpAddress < ActiveRecord::Migration
  def change
    add_index :ip_addr_usages, :ip_address, unique: true
  end
end
