class ReportController < ApplicationController
  def index
    #show all incidents by created at descendent order
    # @incidents = Incident.where(supervisor_id)order(created_at: :desc) 
    #show all incidents except the ones that supervisor_id is not null or different from current user id
    if current_user.supervisor?
      @incidents = Incident.where(supervisor_id: current_user.id).order(created_at: :desc) + Incident.where(supervisor_id: nil).order(created_at: :desc)
    end
  end
end
