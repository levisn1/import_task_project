class CandidatesController < ApplicationController
  def index
    @candidate = Candidate.all
  end
end
