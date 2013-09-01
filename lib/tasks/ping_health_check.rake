# require 'net/ping'

# cmd: "$ bundle exec rake to=[mailaddress] health_check"
task health_check: :environment do
  usages = IpAddrUsage.all
  usages.each do |usage|
    pinger = Net::Ping::External.new(usage.ip_address)
    if pinger.ping?
      usage.ping_failure_count = 0
    else 
      usage.ping_failure_count = usage.ping_failure_count + 1
    end
    usage.save
  end

  if not IpAddrUsage.all_of_unreachable.empty?
    UnreachableAddrNotifier.send_notification(ENV['to']).deliver
  end
end
