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

  # ping_failure_countの状態を表すbootstrapのCSSクラスを戻す
  def status
    case ping_failure_count
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
  scope :unreachable, where("ping_failure_count >= ?", THRESHOLD)
end
