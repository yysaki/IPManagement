class UnreachableAddrNotifier < ActionMailer::Base
  default from: "notifications@example.com"

  def send_notification(email)
    @unreachable_usages = IpAddrUsage.all_of_unreachable.sort
    mail(:to => email,
         :subject => "IPアドレス登録解除忘れのリマインダー") do |format|
      format.text
    end
  end

  def hello_email(email)
    @email = email
    @url = "http://example.com/login"
    mail(:to => email,
         :subject => "Welcome to My Awesome Site") do |format|
      format.text
    end
  end
end
