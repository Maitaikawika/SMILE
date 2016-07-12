class RosecruciansController < ApplicationController
  before_filter :authenticate_user!

  def new
    @rosecrucian = Rosecrucian.new
  end

  def index
    @rosecrucian = Rosecrucian.new
  end

  def create
    @rosecrucian = Rosecrucian.new(params[:rosecrucian])
    if @rosecrucian.invalid?
      render :index
    else
      birth_month = params[:rosecrucian][:birth_month]
      birth_day = params[:rosecrucian][:birth_day]
      month = params[:rosecrucian][:month]
      day = params[:rosecrucian][:day]
      year = params[:rosecrucian][:year]
      length = params[:rosecrucian][:length]
      @roseperiods = Rosecrucian.periods(birth_month, birth_day, year, month, day, length)
    end
  end

  def show
  end

end
