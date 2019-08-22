class CocktailsController < ApplicationController
  before_action :set_cocktails, only: [:index]
  before_action :set_cocktail, only: [:show]

  def index
  end

  def show
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    cocktail_name = params[:cocktail][:name]
    @cocktail = Cocktail.new(name: cocktail_name)
    @cocktail.save!
    redirect_to cocktail_path(@cocktail)
  end

  def set_cocktails
    @cocktails = Cocktail.all
  end

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end
end
