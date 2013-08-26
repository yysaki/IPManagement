require 'spec_helper'

describe "IP address usage pages" do
  subject { page }

  describe "index page" do
    before { visit index_path }

    it { should have_content('IP') }
    it { should have_title('IPManagement') }
  end
end
