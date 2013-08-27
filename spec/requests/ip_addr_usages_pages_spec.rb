require 'spec_helper'

describe "IP address usage pages" do
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

  describe "edit" do
    let(:usage) { FactoryGirl.create(:ip_addr_usage) } 
    before { visit edit_ip_addr_usage_path(usage) }

    describe "with no change" do
      before { click_button "Save changes"}
      it { should have_selector('div.alert.alert-success') }
      it { should have_content('割り当て済みIPアドレス') }
    end
  end
end
