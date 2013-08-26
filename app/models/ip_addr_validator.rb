# coding: utf-8

class IpAddrValidator < ActiveModel::EachValidator
  def validate_each( record, attribute, value )
    unless value =~ Resolv::IPv4::Regex or value =~ Resolv::IPv6::Regex
      record.errors.add(attribute, 'is not IP address')
    end
  end
end

