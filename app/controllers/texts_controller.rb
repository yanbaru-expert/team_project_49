class TextsController < ApplicationController
  def index
    if params[:genre].in?(genre: ["Basic", "Git", "Ruby", "Ruby on Rails"])
      @texts = Text.where(genre: params[:genre])
    else
      @texts = Text.where(genre: ["Basic", "Git", "Ruby", "Ruby on Rails"])
    end
  end
end
