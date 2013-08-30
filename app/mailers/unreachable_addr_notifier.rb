class UnreachableAddrNotifier < ActionMailer::Base
  default from: "notifications@example.com"
  def hello_email(email)
    @email = email
    @url = "http://example.com/login"
    mail(:to => email,
         :subject => "Welcome to My Awesome Site") do |format|
      format.text
    end
  end
end
