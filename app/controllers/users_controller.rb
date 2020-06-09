class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  private

  # Only allow a list of trusted parameters through.
end
