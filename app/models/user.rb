class User < ApplicationRecord
  has_secure_token :browsing_token
  has_secure_token :invitation_token
  has_secure_token :password_reset_token

  enum status: {invited: 0, active: 1, suspended: 2}

	has_secure_password validations: false

	validates_length_of :password, minimum: 6, allow_blank: true
	validates :email, presence: true, uniqueness: true

	before_create :invite
  before_save :secure
	private

	def invite
		self.invitation_sent_at = Time.zone.now
		self.status = 'invited'

		UsersMailer.with(user: self).invitation.deliver
	end

  def secure
    if password_digest.present? and password_digest_changed?
      self.invitation_token = nil
      self.invitation_sent_at = nil
      self.password_reset_token = nil
      self.password_reset_sent_at = nil
      self.status = 'active' if invited?
    end
  end
end
