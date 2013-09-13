class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def contact(contact)
    @contact = contact
    mail(:to => 'info@whenisitopen.ca', :subject => "Contact")
  end
end
