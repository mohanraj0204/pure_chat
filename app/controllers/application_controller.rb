class ApplicationController < ActionController::Base
	#protect _from_forgery with: :exception
	include SessionsHelper
end
