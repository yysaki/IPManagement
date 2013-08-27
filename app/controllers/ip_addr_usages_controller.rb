class IpAddrUsagesController < ApplicationController
  def index
    @usages = IpAddrUsage.all
  end

  def edit
    @usage = IpAddrUsage.find(params[:id])
  end

  def update
    @usage = IpAddrUsage.find(params[:id])
    if @usage.update_attributes(user_params)
      flash[:success] = "Usage updated"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def user_params
    params.require(:ip_addr_usage).permit(:ip_address, :user,
                                          :machine_name,
                                          :location, :note)
  end
end
