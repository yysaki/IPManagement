class IpAddrUsagesController < ApplicationController
  def index
    @usages = IpAddrUsage.all
  end
end
