require 'spec_helper'

describe AvailableIpAddress do
  before { @address = FactoryGirl.create(:available_ip_address) }
  let(:usage) do 
    address.build_ip_addr_usage(
      ip_address: "192.168.15.1", user: "y_sasaki",
      machine_name: "vagrant1", location: "VM1",
      note: "test", failed_ping_history: 0)
  end 

  subject { @address }

  it { should respond_to(:ip_address) }
  it { should respond_to(:ip_addr_usage) }

  describe "ip_addr_usage association" do
    before { @address.save }

    it "should throw exception when destroyed with ip_addr_usage " do
      lambda {raise @address.destroy}.should raise_error
    end

  end
end
