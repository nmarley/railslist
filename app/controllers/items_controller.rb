class ItemsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: [:destroy, :edit, :update]

  def new
  end

  def edit
  end

  def create
    list = List.find_by_id(params[:list_id])
    @item = list.items.build(params[:list])
    if @item.save
      flash[:success] = "Item created!"
      redirect_to list_path(list.id)
    else
      render 'static_pages/home'
    end
  end

  def destroy
    list = @item.list
    @item.destroy
    redirect_to list_path(list.id)
  end

  private
  def correct_user
    @item = Item.find_by_id(params[:id])
    if @item.list.user != current_user
      redirect_to root_url
    end
  end

end
