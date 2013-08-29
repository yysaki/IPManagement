class AvailableIpAddressesController < ApplicationController
  def create
    @addresses = AvailableIpAddress.all
    @new_address = AvailableIpAddress.new(user_params)
    if is_multiple(@new_address)
      flash[:failure] = "multiple descriptions"

    elsif not @new_address.ip_address_str.blank?
      @new_address.ip_address = @new_address.ip_address_str
      if @new_address.save
        flash[:success] = "IPaddress is created"
      end
    elsif not @new_address.ip_address_lb.blank? and not @new_address.ip_address_ub.blank?
     # if(is_valid_range(ip_address_lb, ip_address_up))
     # 

     # else
     #   flash[:failure] = "invalid range"
     # end

    end

    render 'ip_address/configure'
  end

  def destroy
    @addresses = AvailableIpAddress.all
    @new_address = AvailableIpAddress.new(user_params)
    render 'ip_address/configure'
  end

  private
    def user_params
      params.require(:available_ip_address).permit(:ip_address_str, 
                                            :ip_address_lb,
                                            :ip_address_ub)
    end

    def is_multiple(address)
      not address.ip_address_str.blank? and 
        (not address.ip_address_lb.blank? or not address.ip_address_ub.blank?)
    end
  # end private
end
