class ListingMailer < ApplicationMailer
  # default :from => "you@example.com"

   def email_notification(user,listing)
   	@listing = listing
    mail(:to => user.email, :subject => "Listing Confirmation")
   end
    
end
