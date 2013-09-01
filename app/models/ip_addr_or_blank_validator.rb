# coding: utf-8

class IpAddrOrBlankValidator < ActiveModel::EachValidator
  def validate_each( record, attribute, value )
    unless value =~ Resolv::IPv4::Regex or value =~ Resolv::IPv6::Regex or value.blank?
      record.errors.add(attribute, 'is not IP address nor blank')
    end
  end
end

