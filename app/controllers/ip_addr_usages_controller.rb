class IpAddrUsagesController < ApplicationController
  def index
    @usages = IpAddrUsage.all
  end

  def new
    @usage = IpAddrUsage.new
    @ip_addresses = IpAddrUsage.all.map { |u| u.ip_address }
  end

  def create
    @usage = IpAddrUsage.new(user_params)
    @usage.available_ip_address_id = AvailableIpAddress.find_by_ip_address(@usage.ip_address_str).id
    @usage.available_ip_address = AvailableIpAddress.find_by_ip_address(@usage.ip_address_str)
    if @usage.save
      flash[:success] = "Usage is created"
      redirect_to root_path
    else
      @ip_addresses = IpAddrUsage.all.map { |u| u.ip_address }
      render 'new'
    end
  end

  def edit
    @usage = IpAddrUsage.find(params[:id])
    @ip_addresses = IpAddrUsage.all.map { |u| u.ip_address }
  end

  def update
    @usage = IpAddrUsage.find(params[:id])
    if @usage.update_attributes(user_params)
      flash[:success] = "Usage updated."
      redirect_to root_path
    else
      @ip_addresses = IpAddrUsage.all.map { |u| u.ip_address }
      render 'edit'
    end
  end

  def destroy
    @usage = IpAddrUsage.find(params[:id]).destroy
    flash[:success] = "Usage destroyed."
    redirect_to root_path
  end
 
  private
    def user_params
      params.require(:ip_addr_usage).permit(:ip_address_str, :user,
                                            :machine_name,
                                            :location, :note)
    end
  # end private
end
