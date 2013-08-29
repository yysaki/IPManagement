class AddInitialValueToFailedPingHistory < ActiveRecord::Migration
  def change
    change_column_default(:ip_addr_usages, :failed_ping_history, 0)
  end
end
