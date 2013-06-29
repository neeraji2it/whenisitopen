class HomeController < ApplicationController
  layout :get_layout, :except => ['terms_and_conditions']
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
      UserMailer.contact(@contact).deliver
      redirect_to "/"
    else
      render :action => 'new_contact'
    end
  end

  def terms_and_conditions
    send_file File.join(Rails.root,"lib/TermsandConditionsDoc.pdf"),
      :type => 'pdf',
      :file_name => "Terms and Conditions",
      :disposition => 'inline',
      :stream => false
  end
end
