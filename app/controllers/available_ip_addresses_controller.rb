class AvailableIpAddressesController < ApplicationController
  def configure
    @addresses = AvailableIpAddress.all
    @new_address = AvailableIpAddress.new
  end

  def create
    @addresses = AvailableIpAddress.all
    @new_address = AvailableIpAddress.new(user_params)
    if is_multiple(@new_address)
      flash[:failure] = "multiple descriptions"

    elsif not @new_address.ip_address_str.blank?
      @new_address.ip_address = @new_address.ip_address_str
      if @new_address.save
        flash[:success] = "IPaddress is created"
        redirect_to config_path
        return
      end

    elsif not @new_address.ip_address_lb.blank? and not @new_address.ip_address_ub.blank?
      if is_valid_range(@new_address.ip_address_lb, @new_address.ip_address_ub)
        to_array(@new_address.ip_address_lb, @new_address.ip_address_ub).each do |add|
          AvailableIpAddress.create!(ip_address: add) 
        end
        flash[:success] = "IPaddresses are created"
        redirect_to config_path
        return
      else
        flash[:failure] = "invalid range"
      end

    else 
      flash[:failure] = "text fields are blank"
    end

    render 'configure'
  end

  def destroy
    @addresses = AvailableIpAddress.all
    @new_address = AvailableIpAddress.find(params[:id]).destroy
    flash[:success] = "Usage destroyed."
    redirect_to config_path
  end
 
  private
    def user_params
      params.require(:available_ip_address).permit(:ip_address, :ip_address_str, 
                                                   :ip_address_lb, :ip_address_ub)
    end

    def is_multiple(address)
      not address.ip_address_str.blank? and 
        (not address.ip_address_lb.blank? or not address.ip_address_ub.blank?)
    end

    # IPv4を想定
    def is_valid_range(lb, ub)
      if(AvailableIpAddress.new(ip_address: lb).valid? and AvailableIpAddress.new(ip_address: ub).valid?)
        lb_arr = lb.split('.').map { |i| i.to_i } 
        ub_arr = ub.split('.').map { |i| i.to_i }
        if(lb_arr[0] == ub_arr[0] && lb_arr[1] == ub_arr[1] && lb_arr[2] == ub_arr[2] && 
           lb_arr[3] < ub_arr[3])
          return true
        end
      end

      return false
    end
    
    def to_array(lb, ub)
      lb_arr = lb.split('.').map { |i| i.to_i } 
      ub_arr = ub.split('.').map { |i| i.to_i }
      ret_arr = []
      lb_arr[3].upto(ub_arr[3]) do |n|
        ret_arr.push("#{lb_arr[0]}.#{lb_arr[1]}.#{lb_arr[2]}.#{n}")
      end

      return ret_arr
    end

  # end private
end
