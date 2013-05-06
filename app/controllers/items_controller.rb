class ItemsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: [:destroy, :edit, :update]

  def new
  end

  def edit
  end

  def show
    @item = Item.find_by_id(params[:id])
  end

  def update
    if @item.update_attributes(params[:item])
      flash[:success] = "Item updated!"
      redirect_to list_path(@item.list.id)
    else
      render 'edit'
    end
  end

  def create
    list = List.find_by_id(params[:item][:list_id])
    if current_user.id != list.user_id
      flash[:error] = "Not list owner"
      redirect_to root_url
      return
    end
    params[:item].delete(:list_id)
    @item = list.items.build(params[:item])
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
    @item.destroy
    redirect_to list_path(list.id)
  end

  def index
    @lists = List.paginate(page: params[:page])
  end

  private
  def correct_user
    @item = Item.find_by_id(params[:id])
    if @item.list.user != current_user
      redirect_to root_url
    end
  end

end
