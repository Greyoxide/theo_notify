class Assignment < ApplicationRecord
  belongs_to :person
  include Filterable

	scope :date_range, -> (range = range.to_a) { where date: range[0]..range[1] }

  default_scope { order(date: :desc) }

  validate :ensure_no_talk_on_same_date

  def ensure_no_talk_on_same_date
    unless Assignment.where(title: self.title.downcase).where(date: self.date).blank?
      errors.add(:title, 'Cannot schedule the same part twice on the same day.')
    end
  end

  enum kind: {primary_part: 0, secondary_part: 1, sound: 2, support: 3, service_group: 4}
end
