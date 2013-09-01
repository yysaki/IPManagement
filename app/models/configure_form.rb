class ConfigureForm
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :ip_addr_single
  attr_accessor :ip_addr_start, :ip_addr_end

  validates :ip_addr_single, ip_addr_or_blank: true
  validates :ip_addr_start, ip_addr_or_blank: true
  validates :ip_addr_end, ip_addr_or_blank: true
end
