class AssignmentsMailer < ApplicationMailer

def notify
  @person = params[:person]
  @assignments = @person.assignments.where(date: [ Date.today..(Date.today + 6.days) ])

  mail to: @person.email, subject: 'Assignment reminders'
end

end
