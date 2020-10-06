namespace :produce do

  task midweek_meetings: :environment do
    day_of_week = Date.parse(ENV['MIDWEEK_MEETING']).wday
    days = (Date.today.beginning_of_month..Date.today.end_of_month).to_a.select { |k| day_of_week == k.wday }

    days.each do |day|
      # First we have to grab the list of parts from WOL
      @parts = PartList.new(day)

      break if @parts.items.blank? # If WOL isnt updated, then jump out of the array
      @parts.append_extras
      @parts.items.each do |part|

        # Determine the type of part
        unless ["Opening Prayer", "Bible Study Reader", "Closing Prayer"].include? ( part )
          sort = 'secondary_part'
        else
          sort = 'primary_part'
        end

        Assignment.create!(
          date: day,
          title: part,
          kind: sort
        )

      end
    end

  end

end
