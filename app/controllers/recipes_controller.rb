class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :destroy, :edit, :update]

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    respond_to do |format|
      if @recipe.save
        format.html { 
          flash[:success] = "Recipe created!"
          redirect_to root_url
        }
        format.json { 
          render action: 'show', status: :created, location: @recipe
        }
      else
        format.html { render action: 'new' }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def index
    @recipes = Recipe.all

    respond_to do |format|
      format.html
      format.json { render json: @recipes }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url }
      format.json { head :no_content }
    end
  end

  private
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :instructions, :ingredients)
  end

end
