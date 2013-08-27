class IpAddrUsagesController < ApplicationController
  def index
    @usages = IpAddrUsage.all
  end

  def new
    @usage = IpAddrUsage.new
  end

  def create
    @usage = IpAddrUsage.new(user_params)
    if @usage.save
      flash[:success] = "Usage is created"
      redirect_to root_path
    else
      render 'new'
    end
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

  private
    def user_params
      params.require(:ip_addr_usage).permit(:ip_address, :user,
                                            :machine_name,
                                            :location, :note)
    end
  # end private
end
