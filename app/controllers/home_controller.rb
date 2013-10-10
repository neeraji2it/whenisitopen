class HomeController < ApplicationController
  layout :get_layout
  def aboutus
    @title = "About Us"
  end

  def new_contact
    @title = "Contact Us"
    @contact=Contact.new
  end

  def post_contact
    @title = "Contact Us"
    @contact = Contact.new(params[:contact])
    if @contact.save
      flash[:notice] = "Thank you for contacting us. We will review your message as shortly."
      UserMailer.contact(@contact).deliver
      redirect_to "/"
    else
      render :action => 'new_contact'
    end
  end

  def terms_and_conditions
    @title = "Terms and Conditions"
  end
end
