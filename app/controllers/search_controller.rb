class SearchController < ApplicationController
  before_action :signed_in_user

  def index
    @items = Item.search(params[:search]).for_user(current_user.id)
    @total_items = @items.size
    @items = @items.paginate(page: params[:page])
  end

end
