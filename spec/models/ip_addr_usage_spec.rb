require 'spec_helper'

describe IpAddrUsage do
  before do
    @usage = 
      IpAddrUsage.new(ip_address: "192.168.15.1",
                      user: "y_sasaki", machine_name:"vagrant",
                      location:"VM", note: "test",
                      failed_ping_history: 0)
  end

  subject { @usage }

  it { should respond_to(:ip_address) }
  it { should respond_to(:user) }
  it { should respond_to(:machine_name) }
  it { should respond_to(:location) }
  it { should respond_to(:note) }
  it { should respond_to(:failed_ping_history) }
end
