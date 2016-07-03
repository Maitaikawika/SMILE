class NumerologiesController < ApplicationController
  def new
    @numerology = Numerology.new
  end

  def index
    @numerology = Numerology.new
  end

  def create
    @numerology = Numerology.new(params[:numerology])
    phrase = params[:numerology][:phrase]
    @numresults = Numerology.analysis(phrase)
  end

  def show
  end
end

