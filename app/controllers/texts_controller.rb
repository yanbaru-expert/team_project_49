class TextsController < ApplicationController
  def index
    @texts = Text.where(genre: ["Basic", "Git", "Ruby", "Ruby on Rails"])
  end
end


