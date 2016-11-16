class ReviewsController < ApplicationController
	
	def new
		@restaurant = Restaurant.find(params[:restaurant])
		
	end
end
