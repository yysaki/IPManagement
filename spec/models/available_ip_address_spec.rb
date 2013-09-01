require 'spec_helper'

describe AvailableIpAddress do
  before { @address = FactoryGirl.create(:available_ip_address) }
  let(:usage) do 
    address.build_ip_addr_usage(
      ip_address: "192.168.15.1", user: "y_sasaki",
      machine_name: "vagrant1", location: "VM1",
      note: "test", ping_failure_count: 0)
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

  it "uniqueness" do
    address_with_same_email = @address.dup
    expect(address_with_same_email).not_to be_valid
  end

  describe "when ip_address is not present" do
    before { @address.ip_address = "" }
    it { should_not be_valid }
  end

  describe "when ip_address is invalid format" do
    it "should be invalid" do
      ip_addresses = %w[192.168.0,1 192.168.0.258]
      ip_addresses.each do |invalid_ip_address|
        @address.ip_address = invalid_ip_address
        expect(@address).not_to be_valid
      end
    end
  end

  describe "when ip_address is valid format" do
    it "should be valid" do
      ip_addresses = %w[192.168.15.1 192.168.0.111 218.225.123.151]
      ip_addresses.each do |invalid_ip_address|
        @address.ip_address = invalid_ip_address
        expect(@address).to be_valid
      end
    end

    it "should be valid in IPv6" do
      ip_addresses = %w[2001:0db8:bd05:01d2:288a:1fc0:0001:10ee]
      ip_addresses.each do |invalid_ip_address|
        @address.ip_address = invalid_ip_address
        expect(@address).to be_valid
      end
    end
  end


end
