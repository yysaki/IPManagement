class IpAddressController < ApplicationController
  def configure
    @addresses = AvailableIpAddress.all
    @new_address = AvailableIpAddress.new
  end
end
