class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def contact(contact)
    @contact = contact
    mail(:to => contact.email, :subject => "Contact")
  end
end
