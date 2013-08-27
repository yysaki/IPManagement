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

    describe "with invalid information" do
      before do
        fill_in "IPアドレス", with: "192,168,15,10"
        click_button "Save changes"
      end

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name) { "y_sasaki" }
      let(:new_machine_name) { "vagrant" }
      let(:new_location) { "vm" }
      before do
        fill_in "利用者", with: new_name
        fill_in "マシン名", with: new_machine_name
        fill_in "位置", with: new_location
        click_button "Save changes"
      end

      it { should have_selector('div.alert.alert-success') }
      it { should have_content('割り当て済みIPアドレス') }
      it { should have_content(new_name) }
      it { should have_content(new_machine_name) }
      it { should have_content(new_location) }
    end
  end
end
