class SubscriptionsController < ApplicationController
  before_action :get_unread_messages
  before_filter :authenticate_user! 
  
  def index
    
  	@plans = Plan.where(:status => true)
  end

  def new
  	# @subscription = Subscription.new
    previous_subscription = Subscription.find_by_id(current_user.subscription_id)   
    flash[:error] = "Your already Subscribed #{previous_subscription.plan.title} plan. Existing plan will be overide with new selected plan"  if previous_subscription.present?   
  	@plan = Plan.find(params[:plan_id])
  	@subscription = @plan.subscriptions.build
   
  end


   # POST /subscriptions
  def create
    @plan = Plan.find(params[:subscription][:plan_id])
    @subscription = @plan.subscriptions.build
    @subscription.user = current_user
    # @subscription = Subscription.new(subscription_params)
    if @subscription.save
      redirect_to @subscription.paypal_url(subscription_path(@subscription),@plan)
    else
      render :new
    end
  end


  protect_from_forgery except: [:show]
  def show
    # params.permit! # Permit all Paypal input params
    status = params[:st]
    if status == "Completed"
      @subscription = Subscription.find params[:id]
      @subscription.update_attributes( notification_params: params, status: status, transaction_id: params[:tx], purchased_at: Time.now)
      current_user.update_attributes(:subscription_id => @subscription.id)
      flash[:success] = "Your Subscription is successfully Completed."
    else
      flash[:error] = "Error with Subscription please try after some time"
    end
     redirect_to user_dashboard_url   
  end


   

  private
  def get_unread_messages
    @unread = current_user.messages.where(:status => nil).length
  end


  def subscription_params
  	 params.require(:subscription).permit(:plan_id,:user_id,:email)
  end


end
