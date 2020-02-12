class UsersMailer < ApplicationMailer

	def invitation
		@user = params[:user]
		@joke = Joke.new
		mail(to: @user.email, subject: 'Welcome to Notify! V2')
  end

  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
