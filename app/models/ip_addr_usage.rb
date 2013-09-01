class IpAddrUsage < ActiveRecord::Base
  belongs_to :available_ip_address 
  validates :user, presence: true
  validates :location, presence: true
  validates :available_ip_address_id, presence: true,
                         uniqueness: true

  def ip_address
    self.available_ip_address.ip_address 
  end

  def <=>(rhs)
    available_ip_address <=> rhs.available_ip_address
  end

  # failed_ping_historyの状態を表すbootstrapのCSSクラスを戻す
  def status
    case failed_ping_history
    when 0
      ""
    when 1...THRESHOLD
      "text-warning"
    else
      "text-error"
    end
  end

  # ping到達不能を示す閾値
  THRESHOLD = 7
  scope :unreachable, where("failed_ping_history >= ?", THRESHOLD)
end
