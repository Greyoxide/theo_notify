class ApplicationController < ActionController::Base
  include AuthHelper

	before_action :capture_path, if: :current_user
end
