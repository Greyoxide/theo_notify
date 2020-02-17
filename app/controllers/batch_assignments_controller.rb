class BatchAssignmentsController < ApplicationController
  def new
    @assignment = Assignment.new
  end
end
