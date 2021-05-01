class TextsController < ApplicationController
  def index
    if params[:genre].in?(genre: params[5..15])
      @texts = Text.where(genre: params[:genre])
    else
      @texts = Text.where(genre: ["Basic", "Git", "Ruby", "Ruby on Rails"])
    end
  end
end
