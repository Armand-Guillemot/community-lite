class ReviewsController < ApplicationController
  before_action :set_review, only: [:destroy]
  before_action :set_meal, only: [:create, :new]


  # GET /reviews/new
  def new
    @review = Review.new
    authorize @review
  end


  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @review.meal = @meal
    @review.user = current_user
    authorize @review
    respond_to do |format|
      if @review.save
        counter = 0
        @meal.reviews.each { |review| counter += review.rating }
        @meal.rating = counter / @meal.reviews.count
        @meal.save
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
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = Review.find(params[:id])
    authorize @review
  end

  def set_meal
    @meal = Meal.find(params[:meal_id])
    authorize @meal
  end

  # Only allow a list of trusted parameters through.
  def review_params
    params.require(:review).permit(:title, :content, :rating)
  end
end
