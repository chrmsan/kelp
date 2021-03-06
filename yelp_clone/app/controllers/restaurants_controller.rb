class RestaurantsController < ApplicationController
	def index
		@restaurants = Restaurant.all
	end

	def new
		@restaurant = Restaurant.new
	end

	def create
		Restaurant.create(restaurant_params)
		redirect_to restaurants_path
	end

	def show
		@restaurant = Restaurant.find(params[:id])
	end

	def edit
		@restaurant = Restaurant.find(params[:id])
	end

	def update
		@restaurant = Restaurant.find(params[:id])
		@restaurant.update(restaurant_params)
		redirect_to restaurants_path
	end

	private
	def restaurant_params
		params.require(:restaurant).permit(:name, :description, :rating)
	end

end
