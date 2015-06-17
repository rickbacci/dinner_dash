class CategoriesController < ApplicationController
  def index
    @user = User.find(session[:user_id]) if session[:user_id]
    @categories = Category.all
  end
end