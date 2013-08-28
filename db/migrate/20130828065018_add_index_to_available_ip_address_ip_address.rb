class AddIndexToAvailableIpAddressIpAddress < ActiveRecord::Migration
  def change
    add_index :available_ip_addresses, :ip_address, unique: true
  end
end
