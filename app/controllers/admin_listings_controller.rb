class AdminListingsController < ApplicationController
  layout 'admin'
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin!
  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.all
     respond_to do |format|
        format.html # don't forget if you pass html
        format.xls { send_data(@listings.to_xls) }       
      end
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    @listing = Listing.new
    @amenities = Amenity.all
    @rules = Rule.all
    @pictures = @listing.pictures
  end

  # GET /listings/1/edit
  def edit
   
  end


  def import
    Listing.import(params[:file])
    redirect_to admin_listings_url
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = current_admin.listings.build(listing_params)

    respond_to do |format|
      if @listing.save

        if params[:pictures]
        #===== The magic is here ;)
          params[:pictures].each { |image|
            @listing.pictures.create(file: image)
          }
        end

        format.html { redirect_to admin_listings_url, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update

    respond_to do |format|
      if @listing.update_attributes(listing_params)
         if params[:pictures]
        #===== The magic is here ;)
          params[:pictures].each { |image|            
            @listing.pictures.create(file: image)
          }       
        end
        format.html { redirect_to admin_listings_url, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to admin_listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


   def delpic
    @pic = Picture.find(params[:pid])
    @listing = Listing.find(params[:lid])
    @pic.destroy
    redirect_to edit_admin_listing_path(@listing)
  end


  def change_listing_status
    @listing = Listing.find(params[:id])
    @listing.update_attributes(:verified_status => params[:value]) if @listing.present?
    render :text => 'success'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
      @amenities = Amenity.all
      @rules = Rule.all
      @pictures = @listing.pictures
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:title,:description,:room_type,:bedrooms,:rent,:rooms_for_rent,:available_from,:minimumstay,:current_roommates,:prefred_gender,:prefred_age, :prefred_occupation,:phonenumber_visibility,:visible_status,:verified_status,:security_deposit,:furnishing_status,:landmark,:user_id,:area_id,:city_id,:rule_ids => [],:amenity_ids => [])
    end
end
