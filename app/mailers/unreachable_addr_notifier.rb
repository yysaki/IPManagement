class UnreachableAddrNotifier < ActionMailer::Base
  default from: "notifications@example.com"

  def send_notification(email)
    @unreachable_usages = IpAddrUsage.unreachable.all.sort
    mail(:to => email,
         :subject => "IPアドレス登録解除忘れのリマインダー") do |format|
      format.text
    end
  end
end
