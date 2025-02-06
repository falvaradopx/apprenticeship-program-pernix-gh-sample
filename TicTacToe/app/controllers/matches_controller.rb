class MatchesController < ApplicationController
  def index
    @matches = Match.order(created_at: :desc)
  end
end
