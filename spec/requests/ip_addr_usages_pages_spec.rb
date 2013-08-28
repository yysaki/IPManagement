require 'spec_helper'

describe "IP address usage pages" do

  let(:address) { FactoryGirl.create(:available_ip_address) }
  before do
    FactoryGirl.create(:ip_addr_usage, available_ip_address: address)
  end

  subject { page }

  describe "index" do

    before do
      visit root_path
    end

    it { should have_content('割り当て済みIPアドレス') }
    it { should have_content('delete') }

    describe "delete links" do
      it "should be able to delete usage" do
        expect do
          click_link('delete', match: :first)
        end.to change(IpAddrUsage, :count).by(-1)
      end
    end
  end

  describe "new page" do
    before { visit new_ip_addr_usage_path }

    it { should have_content('割り当て') }
  end

#  describe "create usage" do
#    let(:submit) { "Create new usage" }
#    before { visit new_ip_addr_usage_path }
#
#    describe "with invalid information" do
#      it "should not create a user" do
#        expect { click_button submit }.not_to change(IpAddrUsage, :count)
#      end
#
#      describe "should not move page" do
#        before { click_button submit }
#        it { should have_content('割り当て') }
#      end
#    end
#
#    describe "with valid information" do
#      let(:new_ip_address) { "192.168.15.10" }
#      before do
#        select new_ip_address, from: "IPアドレス"
#        fill_in "利用者", with: "osol"
#        fill_in "位置", with: "実機"
#        fill_in "備考", with: "vm1.websys.timedia.co.jp # in websys server room"
#      end
#
#      it "should create a user" do
#        expect { click_button submit }.to change(IpAddrUsage, :count).by(1)
#      end
#
#      describe "after saving the user" do
#        before { click_button submit }
#        it { should have_content('割り当て済みIPアドレス') }
#        it { should have_content(new_ip_address) }
#        it { should have_selector('div.alert.alert-success') }
#      end
#    end
#  end


  describe "edit page" do
    let(:usage) { FactoryGirl.create(:ip_addr_usage) } 
    before { visit edit_ip_addr_usage_path(usage) }

    it { should have_content('編集') }
  end

  describe "edit" do
    let(:submit) { "Save changes" }
    let(:usage) { FactoryGirl.create(:ip_addr_usage) } 
    before { visit edit_ip_addr_usage_path(usage) }

    describe "with no change" do
      before { click_button submit}
      it { should have_selector('div.alert.alert-success') }
      it { should have_content('割り当て済みIPアドレス') }
    end

    describe "with invalid information" do
      before do
        fill_in "利用者", with: ""
        click_button submit
      end

      it { should have_content('error') }
      it { should have_content('編集') }
    end

    describe "with valid information" do
      let(:new_name) { "y_sasaki" }
      let(:new_machine_name) { "vagrant" }
      let(:new_location) { "vm" }
      before do
        fill_in "利用者", with: new_name
        fill_in "マシン名", with: new_machine_name
        fill_in "位置", with: new_location
        click_button submit
      end

      it { should have_selector('div.alert.alert-success') }
      it { should have_content('割り当て済みIPアドレス') }
      it { should have_content(new_name) }
      it { should have_content(new_machine_name) }
      it { should have_content(new_location) }
    end
  end
end
