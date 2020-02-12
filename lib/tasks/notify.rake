namespace :notify do

  task people: :environment do
    if Date.today.strftime("%A") == "Monday"
      @people = Person.joins(:assignments).where(assignments: { date: [Date.today..(Date.today + 6.days)] }).uniq
      @people.each do |person|
        @person = person
        @assignments = @person.assignments.where(date: [ Date.today..(Date.today + 6.days) ])
        AssignmentsMailer.with(person: @person, assignments: @assignments).notify.deliver_later
      end
    end
  end

end
