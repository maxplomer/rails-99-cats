class CatsController < ApplicationController
  before_action :make_sure_own_cat, :only => [:edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render(
        :json => @cat.errors.full_messages,
        :status => :unprocessable_entity
      )
    end
  end

  def new
    @cat = Cat.new(color: "blue", name: "fill me out", sex: "M", birth_date: "2014-01-01", description: "fill me out")
    render :new
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      render(
        :json => @cat.errors.full_messages,
        :status => :unprocessable_entity
      )
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def destroy
    Cat.destroy(params[:id])
  end



  private

  def cat_params
    params.require(:cat).permit(:birth_date, :color, :name, :sex, :description)
  end

  def make_sure_own_cat
    @cat = Cat.find(params[:id])
    redirect_to new_session_url if current_user.id.nil?
    redirect_to new_session_url unless @cat.user_id == current_user.id
  end

end
