class CatRequestsController < ApplicationController

  def index
    @rental = CatRentalRequest.all
    render :index
  end

  def create
    @rental = CatRentalRequest.new(rental_params)

    if @rental.save
      redirect_to cat_requests_url
    else
      #flash here
      render :new
    end
  end

  def approve
    CatRentalRequest.find(params[:cat_request_id]).approve!
  end

  def deny
    CatRentalRequest.find(params[:cat_request_id]).deny!
  end

  def rental_params
    params.require(:rental).permit(:cat_id, :start_date, :end_date)
  end
end
