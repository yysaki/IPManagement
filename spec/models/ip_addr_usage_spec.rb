require 'spec_helper'

describe IpAddrUsage do
  before { @usage = FactoryGirl.create(:ip_addr_usage) }
  subject { @usage }

  it { should respond_to(:ip_address) }
  it { should respond_to(:user) }
  it { should respond_to(:machine_name) }
  it { should respond_to(:location) }
  it { should respond_to(:note) }
  it { should respond_to(:failed_ping_history) }

  describe "association check" do
    let(:address) { FactoryGirl.create(:available_ip_address) }
    before do
      @usage = address.build_ip_addr_usage(
        ip_address: "192.168.15.1", user: "y_sasaki",
        machine_name: "vagrant1", location: "VM1",
        note: "test", failed_ping_history: 0)
    end 

    it { should respond_to(:available_ip_address) }
    it { should respond_to(:available_ip_address_id) }
    specify { expect(address).to respond_to(:ip_address) }
  end

  describe "when ip_address is not present" do
    before { @usage.ip_address = "" }
    it { should_not be_valid }
  end

  describe "when ip_address is invalid format" do
    it "should be invalid" do
      ip_addresses = %w[192.168.0,1 192.168.0.258]
      ip_addresses.each do |invalid_ip_address|
        @usage.ip_address = invalid_ip_address
        expect(@usage).not_to be_valid
      end
    end
  end

  describe "when ip_address is valid format" do
    it "should be valid" do
      ip_addresses = %w[192.168.15.1 192.168.0.111 218.225.123.151]
      ip_addresses.each do |invalid_ip_address|
        @usage.ip_address = invalid_ip_address
        expect(@usage).to be_valid
      end
    end

    it "should be valid in IPv6" do
      ip_addresses = %w[2001:0db8:bd05:01d2:288a:1fc0:0001:10ee]
      ip_addresses.each do |invalid_ip_address|
        @usage.ip_address = invalid_ip_address
        expect(@usage).to be_valid
      end
    end
  end

  describe "when user is not present" do
    before { @usage.user = "" }
    it { should_not be_valid }
  end

  describe "when location is not present" do
    before { @usage.location = "" }
    it { should_not be_valid }
  end
end
