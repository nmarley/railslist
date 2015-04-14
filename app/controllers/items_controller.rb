class ItemsController < ApplicationController
  before_action :signed_in_user
  before_action :set_item, only: [:show, :destroy, :edit, :update, :bump]
  #before_action :correct_user,   only: [:destroy, :edit, :update]

  def new
  end

  def edit
    authorize! :update, @item.list
  end

  def bump
    authorize! :update, @item.list
    @item.touch
    redirect_to list_path(@item.list.id)
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @item }
    end
  end

  def update
    authorize! :update, @item.list
    if @item.update_attributes(item_params)
      flash[:success] = "Item updated!"
      redirect_to list_path(@item.list.id)
    else
      render 'edit'
    end
  end

  def create
    #authorize! :update, @item.list
    # TODO: refactor (well, *everything*)
    # list = List.find(item_params[:list_id])
    list = List.find_by_id(params[:item][:list_id])
    authorize! :update, list
    params[:item].delete(:list_id)
    @item = list.items.build(item_params)
    if @item.save
      flash[:success] = "Item created!"
      redirect_to list_path(list.id)
    else
      @items = []
      @list = @item.list
      render "lists/show"
    end
  end

  def destroy
    list = @item.list
    authorize! :delete, list
    @item.destroy
    redirect_to list_path(list.id)
  end

  def index
    @lists = List.paginate(page: params[:page])
  end

  private
  #def correct_user
  #  @item = Item.find_by_id(params[:id])
  #  if @item.list.user != current_user
  #    redirect_to root_url
  #  end
  #end

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_params
    params.require(:item).permit(:content, :list_id)
  end

end
