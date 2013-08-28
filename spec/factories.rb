FactoryGirl.define do
  factory :ip_addr_usage do
    sequence(:ip_address) { |n| "192.168.15.#{n}" }
    user "y_sasaki"
    sequence(:machine_name) {|n| "vagrant#{n}" }
    sequence(:location) {|n| "VM#{n}" }
    note "test"
    failed_ping_history 0
  end

  factory :available_ip_address do
    sequence(:ip_address) { |n| "192.168.15.#{n+1}" }
  end
end
