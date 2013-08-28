require 'spec_helper'

describe AvailableIpAddress do
  before { @address = FactoryGirl.create(:available_ip_address) }
  subject { @address }

  it { should respond_to(:ip_address) }
  it { should respond_to(:ip_addr_usage) }
end
