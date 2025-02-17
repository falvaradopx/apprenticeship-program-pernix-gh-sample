class MatchesController < ApplicationController
  def index
    @matches = Match.order(created_at: :desc).limit(10)
  end
end
