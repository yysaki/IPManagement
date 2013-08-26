class CreateIpAddrUsages < ActiveRecord::Migration
  def change
    create_table :ip_addr_usages do |t|
      t.string :ip_address
      t.string :user
      t.string :machine_name
      t.string :location
      t.string :note
      t.integer :failed_ping_history

      t.timestamps
    end
  end
end
