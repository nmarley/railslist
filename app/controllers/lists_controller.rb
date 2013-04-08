class ListsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def create
    @list = current_user.lists.build(params[:list])
    if @list.save
      flash[:success] = "List created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def index
    @lists = List.paginate(page: params[:page])
  end

  def destroy
    @list.destroy
    redirect_to root_url
  end

  private
  def correct_user
    @list = current_user.lists.find_by_id(params[:id])
    redirect_to root_url if @list.nil?    
  end
  # alternate implementation
  # def correct_user
  #   @list = current_user.lists.find(params[:id])
  # rescue
  #   redirect_to root_url
  # end

end
