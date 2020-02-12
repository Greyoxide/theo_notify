class AssignmentsMailer < ApplicationMailer

def notify
  @person = params[:person]
  @assignments = params[:assignments]

  mail to: @person.email, subject: 'Assignment reminders'
end

end
