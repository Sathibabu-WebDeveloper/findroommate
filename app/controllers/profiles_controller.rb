class ProfilesController < ApplicationController
  before_filter :authenticate_user!
 def update
		 @profile = Profile.find(params[:id])
		 if @profile.update_attributes(profile_params)
         @profile.user.update_attributes(:email => params[:email])
         flash[:error] = 'Your profile is successfully updated.'
     else
      flash[:error] = @profile.errors.full_messages.join(", ")
     end		 
		 redirect_to user_profile_path    
 end


 def update_settings
    @profile = current_user.profile 
    @profile.update_attributes(params[:name] => params[:value])

    render :text => 'success'
  end

 private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:first_name,:last_name,:phone_no,:gender,:dob,:address,:occupation,:about,:user_id,:picture,:profile_visible,:email_notification,:message_notification)
    end
end
