namespace :notify do

  task people: :environment do
    @people = Person.joins(:assignments).where(assignments: { date: [Date.today..(Date.today + 6.days)] }).uniq
    @people.each do |person|
      @person = person
      # @assignments = Assignment.where(person: @person).where(date: [ Date.today..(Date.today + 6.days) ])
      AssignmentsMailer.with(person: @person).notify.deliver_later
    end
  end
end
