class RosecruciansController < ApplicationController
  def new
    @rosecrucian = Rosecrucian.new
  end

  def index
    @rosecrucian = Rosecrucian.new
  end

  def create
    @rosecrucian = Rosecrucian.new(params[:rosecrucian])
    year = params[:rosecrucian][:year]
    month = params[:rosecrucian][:month]
    day = params[:rosecrucian][:day]
    @roseperiods = Rosecrucian.periods(year, month, day)
  end

  def show
  end

end
