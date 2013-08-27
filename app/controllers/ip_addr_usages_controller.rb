class IpAddrUsagesController < ApplicationController
  def index
    @usages = IpAddrUsage.all
  end

  def edit
    @usage = IpAddrUsage.find(params[:id])
  end
end
