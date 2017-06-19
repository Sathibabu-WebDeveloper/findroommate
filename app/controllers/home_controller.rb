class HomeController < ApplicationController
  include ActionView::Helpers::DateHelper
  def index
  	@listings = Listing.where(:verified_status => true)
    @message = Message.new
  end

  def listings_json    
    @listings = Listing.where(:verified_status => true)
    @listings.each do |listing|
      image = Picture.where(:listing_id => listing.id).first
      listing[:image_url] = image.file.url(:thumb) if image.present?
      listing[:up_votes] = listing.get_upvotes.size
      listing[:down_votes] = listing.get_downvotes.size
      listing[:time_ago] = time_ago_in_words(listing.created_at)
    end
    render :json => @listings.as_json(
                      :include => {
                        :area => {:only => [:name]},
                        :city => {:only => [:name]},
                        :amenities => {:only => [:name]},
                        :user => {:only => [:id], :include => {:profile => {:only => [:first_name]}}}
                      })
  end

  def areas_json
     @areas = Area.all
     render :json => @areas.as_json
  end

  def cities_json
    @cities = City.all
     render :json => @cities.as_json
  end

  def amenities_json
    @amenities = Amenity.all
     render :json => @amenities.as_json
  end
  def show
  	@listing = Listing.find(params[:id])
  	@pictures = @listing.pictures
  	@listings = Listing.all.limit(3)
  	@message = Message.new
  end


  def create
  	@listing = Listing.find(params[:message][:listing_id])
  	@message = @listing.messages.build(message_params)
  	if @message.save
  		@message.update_attributes(:user_id => @listing.user.id) if @listing.user.present?
      @message.update_attributes(:admin_id => @listing.admin.id) if @listing.admin.present?
      flash[:success] = "Your Message has been successfully posted.."
  	end
  	redirect_to show_listing_url(@listing)
  end


  def message_params
  	 params.require(:message).permit(:listing_id,:name,:phoneno,:message)
  end
end
