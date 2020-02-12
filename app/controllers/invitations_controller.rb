class InvitationsController < ApplicationController
  def new
  end

  def edit
		@user = User.find_by_invitation_token(params[:id])
    if @user.blank?
      flash[:notification] = 'It looks like something went wrong, this invitation is invalid'
      redirect_to signin_path
    elsif @user.invitation_sent_at < Time.zone.now - 24.hours
      flash[:notification] = "This invitation has expired"
    end
  end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			session[:user_id] = @user.browsing_token
			redirect_to assignments_path
		else
			render :edit
		end
	end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
