# require 'net/ping'

# cmd: "$ bundle exec rake to=[mailaddress] db:health_check"
namespace :db do
  task health_check: :environment do
    usages = IpAddrUsage.all
    usages.each do |usage|
      pinger = Net::Ping::External.new(usage.ip_address)
      if pinger.ping?
        usage.failed_ping_history = 0
      else 
        usage.failed_ping_history = usage.failed_ping_history + 1
      end
      usage.save
    end

    if not IpAddrUsage.all_of_unreachable.empty?
      UnreachableAddrNotifier.send_notification(ENV['to']).deliver
    end
  end
end
