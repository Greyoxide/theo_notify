class Assignment < ApplicationRecord
  belongs_to :person, optional: true
  include Filterable

  default_scope { order(date: :desc) }

  validate :ensure_no_talk_on_same_date

  def ensure_no_talk_on_same_date
    unless Assignment.where(title: self.title.downcase).where(date: self.date).blank?
      errors.add(:title, 'Cannot schedule the same part twice on the same day.')
    end
  end

  enum kind: {primary_part: 0, secondary_part: 1, sound: 2, support: 3, service_group: 4}
  enum status: { unassigned: 0, assigned: 1 }

  before_save :update_status

  def update_status
    self.status = 'unassigned' if self.person_id.blank?
    self.status = 'assigned' if self.person_id.present?
  end

  scope :by_kind, -> (kinds) { where kind: kinds unless (kinds - ['', nil]).empty? }
  scope :by_status, -> (status) { where status: status if status.present? }
  scope :starts_with, -> (name) { where("title ilike ?", "#{name}%") }
end
