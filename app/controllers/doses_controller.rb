class DosesController < ApplicationController
  # before_action :set_cocktails, only: [:index]
  before_action :set_cocktail, only: [:new, :create, :delete]

  def new
    @dose = Dose.new
  end

  def create
    new_ingredient = Ingredient.find(params[:dose][:ingredient_id])
    amount = params[:dose][:amount]
    new_description = "Add #{amount} #{new_ingredient.name}"
    @dose = Dose.new(description: new_description, ingredient_id: new_ingredient.id, cocktail_id: @cocktail.id)
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render 'new'
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy
    @cocktail = Cocktail.find(params[:cocktail_id])
    redirect_to cocktail_path(@cocktail)
  end

  def set_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end
end
