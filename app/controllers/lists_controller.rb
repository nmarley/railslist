class ListsController < ApplicationController
  before_action :signed_in_user
  before_action :set_list,   only: [:show, :destroy, :edit, :update]

  def create
    @list = current_user.lists.build(list_params)
    if @list.save
      redirect_to root_url, success: 'List created!'
    # wth was I thinking...?
    else
      @lists = []
      render 'static_pages/home'
    end
  end

  def update
    authorize! :update, @list
    if @list.update_attributes(list_params)
      redirect_to @list, success: 'List updated'
    else
      render 'edit'
    end
  end

  def show
    # for item form (which is displayed on lists page)
    @item = @list.items.build
    @items = @list.items.paginate(page: params[:page])
  end

  def index
    @lists = List.search(params[:search])
      .where(user_id: current_user.id)
      .paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @lists }
    end
  end

  def destroy
    authorize! :delete, @list
    if @list.items.any?
      flash[:error] = 'Cannot delete a list with items.'
    else
      @list.destroy
    end
    redirect_to root_url
  end

  def edit
    authorize! :update, @list
  end

  private
  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :private)
  end

end
