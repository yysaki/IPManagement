class IpAddrUsagesController < ApplicationController
  def index
    @usages = IpAddrUsage.all
  end

  def new
    @usage = IpAddrUsage.new
    @unused_addr_map = AvailableIpAddress.unused.map { |addr| [addr.ip_address, addr.id] }
  end

  def create
    @usage = IpAddrUsage.new(user_params)
    @usage.available_ip_address = AvailableIpAddress.find(@usage.available_ip_address_id)
    if @usage.save
      flash[:success] = "Usage is created"
      redirect_to root_path
    else
      @unused_addr_map = AvailableIpAddress.unused.map { |addr| [addr.ip_address, addr.id] }
      render 'new'
    end
  end

  def edit
    @usage = IpAddrUsage.find(params[:id])
  end

  def update
    @usage = IpAddrUsage.find(params[:id])
    if @usage.update_attributes(user_params)
      flash[:success] = "Usage updated."
      redirect_to root_path
    else
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
      params.require(:ip_addr_usage).permit(:available_ip_address_id , :user,
                                            :machine_name,
                                            :location, :note)
    end
  # end private
end
