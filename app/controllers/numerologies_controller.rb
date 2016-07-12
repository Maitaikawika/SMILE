class NumerologiesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @numerology = Numerology.new
  end

  def create
    @numerology = Numerology.new(params[:numerology])
    if @numerology.invalid?
      render :index
    else
      @numresults = Numerology.analysis(params[:numerology][:phrase])
    end
  end

end

