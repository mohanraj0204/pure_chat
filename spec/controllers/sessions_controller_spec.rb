require 'spec_helper'

RSpec.describe SessionsController do
	subject {page}
	describe "signin page" do
		before{visit signin_path}

		describe "Invalid sigin" do
			before {click_button "Sign In"}

			it {should have_title(full_title('SignIn'))}
			it {should have_selector('div.alert.alert-error')}
		end
		describe "valid signin" do
			let(:user) {FactoryGirl.create(:user)}
			before do
				fill_in "Email",    with: user.email.upcase
				fill_in "Password", with: user.password
				click_button "Sign In"
			end
			#it {should have_link('Sign Out' ,href: signout_path)}
		end
	end
end