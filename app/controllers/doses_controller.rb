class DosesController < ApplicationController
  # before_action :set_cocktails, only: [:index]
  before_action :set_cocktail, only: [:new, :create]

  def new
    @dose = Dose.new
  end

  def create
    new_ingredient = Ingredient.find(params[:dose][:ingredient_id].to_i)
    amount = params[:dose][:amount]
    new_description = "Add #{amount} #{new_ingredient.name}"
    new_dose = Dose.new(description: new_description, ingredient_id: new_ingredient.id, cocktail_id: @cocktail.id)
    new_dose.save
    redirect_to cocktail_path(@cocktail)
  end

  def destroy
    dose_id = params[:cocktail_id]
    @dose = Dose.find(dose_id.to_i)
    @dose.destroy
    @cocktail = Cocktail.find(params[:id])
    redirect_to cocktail_path(@cocktail)
  end

  def set_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end
end
