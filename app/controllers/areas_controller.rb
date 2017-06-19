class AreasController < ApplicationController
  before_filter :authenticate_admin!, except: [:area_list]
  layout 'admin'
  before_action :set_area, only: [:show, :edit, :update, :destroy]

  # GET /areas
  # GET /areas.json
  def index
    @areas = Area.all
    respond_to do |format|
        format.html # don't forget if you pass html
        format.xls { send_data(@areas.to_xls(:only => [:id, :name, :pincode ,:latitude, :longitude , :city_id])) }       
      end
  end


  def area_list
    @city = City.where(:id => params[:city_id]).first    
    if @city.present?
        @areas = @city.areas.map{|s| [s.name, s.id]}.insert(0, "Select a Area") 
    else
        @areas = Area.all.map{|s| [s.name, s.id]}.insert(0, "Select a Area")
    end
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
  end

  # GET /areas/new
  def new
    @area = Area.new
  end

  # GET /areas/1/edit
  def edit
  end


  def import
    Area.import(params[:file])
    redirect_to areas_url
  end

  # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(area_params)

    respond_to do |format|
      if @area.save
        format.html { redirect_to areas_url, notice: 'Area was successfully created.' }
        format.json { render :show, status: :created, location: @area }
      else
        format.html { render :new }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /areas/1
  # PATCH/PUT /areas/1.json
  def update
    respond_to do |format|
      if @area.update(area_params)
        format.html { redirect_to areas_url, notice: 'Area was successfully updated.' }
        format.json { render :show, status: :ok, location: @area }
      else
        format.html { render :edit }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    @area.destroy
    respond_to do |format|
      format.html { redirect_to areas_url, notice: 'Area was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area
      @area = Area.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def area_params
      params.require(:area).permit(:name,:city_id, :pincode, :latitude, :longitude)
    end
end
