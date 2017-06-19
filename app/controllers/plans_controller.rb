class PlansController < ApplicationController
  before_filter :authenticate_admin!
  layout 'admin'
  before_action :set_plan, only: [:show, :edit, :update, :destroy, :change_plan_status]

  # GET /plans
  # GET /plans.json
  def index
    @plans = Plan.all
      respond_to do |format|
        format.html # don't forget if you pass html
        format.xls { send_data(@plans.to_xls(:only => [:id, :title, :price ,:duration, :description , :limit, :duration_type])) }       
      end
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
  end

  # GET /plans/new
  def new
    @plan = Plan.new
  end

  # GET /plans/1/edit
  def edit
  end


  def import
    Plan.import(params[:file])
    redirect_to plans_url
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = Plan.new(plan_params)

    respond_to do |format|
      if @plan.save
        format.html { redirect_to plans_url, notice: 'Plan was successfully created.' }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to plans_url, notice: 'Plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to plans_url, notice: 'Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def change_plan_status
    @plan.update_attributes(:status => params[:value]) if @plan.present?
    render :text => 'success'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:title,:price, :description, :duration, :duration_type,:limit)     
    end
end
