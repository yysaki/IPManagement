require 'spec_helper'

describe IpAddrUsage do
  before { @usage = FactoryGirl.create(:ip_addr_usage) }
  subject { @usage }

  it { should respond_to(:ip_address) }
  it { should respond_to(:user) }
  it { should respond_to(:machine_name) }
  it { should respond_to(:location) }
  it { should respond_to(:note) }
  it { should respond_to(:ping_failure_count) }

  describe "association check" do
    let(:address) { FactoryGirl.create(:available_ip_address) }
    before do
      @usage = address.build_ip_addr_usage(
        available_ip_address_id: 1, user: "y_sasaki",
        machine_name: "vagrant1", location: "VM1",
        note: "test", ping_failure_count: 0,
        available_ip_address_id: 1)
    end 

    it { should respond_to(:available_ip_address) }
    it { should respond_to(:available_ip_address_id) }
    specify { expect(address).to respond_to(:ip_address) }

    describe "uniqueness" do
      before do
        usage_with_same_email = @usage.dup
        usage_with_same_email.save
      end
      it { should_not be_valid }
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
