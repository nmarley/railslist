class StaticPagesController < ApplicationController

  def home
    if signed_in?
      @list       = current_user.lists.build
      @feed_items = current_user.feed
        .search(params[:search])
        .paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
