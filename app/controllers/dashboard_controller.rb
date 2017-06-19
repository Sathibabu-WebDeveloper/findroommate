class DashboardController < ApplicationController
before_filter :authenticate_admin!
layout 'admin'
  def index
  end

  def messages
  	@messages = current_admin.messages.all
  end

  def destroy_message
    @messages = Message.find(params[:ids])
    @messages.each do |msg|
      msg.destroy
    end
     flash[:success] = "Messages are successfully deleted."     
     render :js => "window.location = '/messages'" 
  end

  def subscriptions
    @subscriptions = Subscription.all
  end


end
