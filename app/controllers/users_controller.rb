class UsersController < ApplicationController
  before_filter :authenticate_admin!
  layout 'admin'
  def index
  	@users =  User.search(params[:search]).paginate(:per_page => 10, :page => params[:page])
  	respond_to do |format|
        format.html # don't forget if you pass html
        format.xls { send_data(@users.to_xls(:only => [:id, :email])) }       
      end
  end  

end
