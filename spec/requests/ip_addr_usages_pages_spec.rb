require 'spec_helper'

describe "IP address usages" do
  subject { page }

  describe "index page" do
    before { visit root_path }

    it { should have_content('IpAddr') }
  end
end
