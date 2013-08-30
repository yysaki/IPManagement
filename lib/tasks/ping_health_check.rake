# require 'net/ping'
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
  end

  task send_mail: :environment do
    UnreachableAddrNotifier.send_notification(ENV['to']).deliver
  end
end
