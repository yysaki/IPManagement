FactoryGirl.define do
  factory :ip_addr_usage do
    sequence(:available_ip_address_id) { |n| n+1 }
    user "y_sasaki"
    sequence(:machine_name) {|n| "vagrant#{n+1}" }
    sequence(:location) {|n| "VM#{n+1}" }
    note "test"
    failed_ping_history 0
    available_ip_address
  end

  factory :available_ip_address do
    sequence(:ip_address) { |n| "192.168.15.#{n+1}" }
  end
end
