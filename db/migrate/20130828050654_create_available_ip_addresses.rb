class CreateAvailableIpAddresses < ActiveRecord::Migration
  def change
    create_table :available_ip_addresses do |t|
      t.string :ip_address

      t.timestamps
    end
  end
end
