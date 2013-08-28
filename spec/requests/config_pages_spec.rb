require 'spec_helper'

describe "ConfigPages" do
  describe "config page" do
    before { visit config_path }

    it { should have_content('範囲設定') }
  end
end
