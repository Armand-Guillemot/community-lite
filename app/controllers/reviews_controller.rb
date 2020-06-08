class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :destroy]
  before_action :set_meal, only: [:create, :new]


  # GET /reviews/new
  def new
    @review = Review.new
  end


  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @review.meal = @meal
    @review.user = current_user
    respond_to do |format|
      if @review.save
        format.html { redirect_to @meal, notice: 'Review was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json


  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = Review.find(params[:id])
  end

  def set_meal
    @meal = Meal.find(params[:meal_id])
  end

  # Only allow a list of trusted parameters through.
  def review_params
    params.require(:review).permit(:title, :content, :rating)
  end
end
