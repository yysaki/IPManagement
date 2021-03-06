class AvailableIpAddressesController < ApplicationController
  def configure
    @configure_form = ConfigureForm.new
    @addresses = AvailableIpAddress.all
  end

  def create
    @configure_form = ConfigureForm.new(params[:configure_form])
    @configure_form.valid?
    @new_address = AvailableIpAddress.new
    if are_single_and_range_forms_filled(@configure_form)
      flash[:failure] = "unavailable at the same time range registration and registration alone"

    elsif not @configure_form.ip_addr_single.blank?
      if AvailableIpAddress.new(ip_address: @configure_form.ip_addr_single).save
        flash[:success] = "IPaddress is created"
        redirect_to config_path
        return
      end

    elsif not @configure_form.ip_addr_start.blank? and not @configure_form.ip_addr_end.blank?
      if is_valid_range(@configure_form.ip_addr_start, @configure_form.ip_addr_end)
        each_ip_addr(@configure_form.ip_addr_start, @configure_form.ip_addr_end) do |addr|
          AvailableIpAddress.create!(ip_address: addr) 
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

    @addresses = AvailableIpAddress.all
    render 'configure'
  end

  def destroy
    AvailableIpAddress.find(params[:id]).destroy
    flash[:success] = "Usage destroyed."
    redirect_to config_path
  end
 
  private
    def user_params
      params.require(:available_ip_address).permit(:ip_address, :ip_addr_single, 
                                                   :ip_addr_start, :ip_addr_end)
    end

    def are_single_and_range_forms_filled(configure_form)
      not configure_form.ip_addr_single.blank? and 
        (not configure_form.ip_addr_start.blank? or not configure_form.ip_addr_end.blank?)
    end

    # IPv4を想定
    def is_valid_range(addr_start, addr_end)
      if(AvailableIpAddress.new(ip_address: addr_start).valid? and AvailableIpAddress.new(ip_address: addr_end).valid?)
        start_arr = addr_start.split('.').map { |i| i.to_i } 
        end_arr = addr_end.split('.').map { |i| i.to_i }
        if(start_arr[0] == end_arr[0] && start_arr[1] == end_arr[1] && start_arr[2] == end_arr[2] && 
           start_arr[3] < end_arr[3])
          return true
        end
      end

      return false
    end
    
    def each_ip_addr(addr_start, addr_end, &block)
      start_arr = addr_start.split('.').map { |i| i.to_i } 
      end_arr = addr_end.split('.').map { |i| i.to_i }
      start_arr[3].upto(end_arr[3]) do |n|
        yield ("#{start_arr[0]}.#{start_arr[1]}.#{start_arr[2]}.#{n}")
      end
    end

  # end private
end
