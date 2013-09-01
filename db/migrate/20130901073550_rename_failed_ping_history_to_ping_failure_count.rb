class RenameFailedPingHistoryToPingFailureCount < ActiveRecord::Migration
  def change
    rename_column :ip_addr_usages, :failed_ping_history, :ping_failure_count
  end
end
