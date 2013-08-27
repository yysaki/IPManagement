require 'spec_helper'

describe "IP address usages" do
  subject { page }

  describe "index page" do
    before { visit root_path }

    it { should have_content('割り当て済みIPアドレス') }
  end
  describe "edit page" do
    let(:usage) { FactoryGirl.create(:ip_addr_usage) } 
    before { visit edit_ip_addr_usage_path(usage) }

    it { should have_content('編集') }
  end
end
