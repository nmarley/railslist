class ListsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: [:destroy, :edit, :update]

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

  def update
    if @list.update_attributes(params[:list])
      flash[:success] = "List updated"
      redirect_to @list
    else
      render 'edit'
    end
  end

  def show
    @list = List.find(params[:id])

    # for item form (which is displayed on lists page)
    @item = @list.items.build

    @items = @list.feed.paginate(page: params[:page])
  end

  def index
    @lists = List.search(params[:search]).
      paginate(page: params[:page]).
      where("user_id = ?", current_user.id)

    respond_to do |format|
      format.html
      format.json { render json: @lists }
    end
  end

  def destroy
    if @list.items.any?
      flash[:error] = 'Cannot delete a list with items.'
    else
      @list.destroy
    end
    redirect_to root_url
  end

  def edit
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
