class UserDashboardController < ApplicationController
	before_filter :authenticate_user! 
  #before_action :password_filed , only: [:update_password]
  before_action :get_unread_messages
  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::TagHelper
  def index
  	@profile = current_user.profile 
  	unless @profile.present?
  		@profile = Profile.new
  		@profile.user = current_user
  		@profile.save!
  	end
    @user = current_user
  end
  def messages    
  	@messages = current_user.messages.order("created_at DESC").paginate(:per_page => 5, :page => params[:page])
  end

  def show_message
    @message = Message.find(params[:id])
    @message.update_attributes(:status => true)
  end

  def destroy_message
    @messages = Message.find(params[:ids])
    @messages.each do |msg|
      msg.destroy
    end
     flash[:success] = "Messages are successfully deleted."
     render :js => "window.location = '/user_messages'" 
  end



  def update_password 
     @user = User.find(current_user.id)
    if @user.update(user_params)
      # Sign in the user by passing validation in case their password changed
      sign_in @user, :bypass => true
      flash[:success] = "Your password is successfully updated."
      redirect_to user_profile_url
    else
     flash[:error] = @user.errors.full_messages.join(", ")
     redirect_to user_profile_url
    end
  end

  def favorites
    @listings = current_user.votes.up.for_type(Listing).votables
  end



  private

  def password_filed
    if params[:user][:password].blank?
    params[:user].delete(:password)
    params[:user].delete(:password_confirmation)
    end
  end

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:email,:password, :password_confirmation,:current_password)
  end

  def get_unread_messages
    @unread = current_user.messages.where(:status => nil).length
  end



end
