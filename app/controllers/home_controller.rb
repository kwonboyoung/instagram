class HomeController < ApplicationController
  def index
  end

  def welcome
  	@name = params[:keyword]
  end
end
