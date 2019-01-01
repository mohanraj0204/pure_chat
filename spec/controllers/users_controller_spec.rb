require 'spec_helper'

describe "User's page" do

	subject {page}

	describe "profile pages" do
		let(:user) {FactoryGirl.create(:user)}
		before { visit user_path(user)}
		
		#it {should have_content('User')}
	end

	describe "Signup Page" do
		before(:each) { visit signup_path}
		let(:submit) {"Create Account"}
	
		describe "Invalid signup" do
			it "not create user" do
				 expect { click_button submit }.not_to change(User, :count)
			end
		end

		describe "Valid signup" do
			before do
				fill_in  "Email",					with: "user@example.com"
				fill_in  "Password",				with: "password"
				fill_in  "Re-Enter Password", 		with: "password"
				
			end
			it "create user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end
		end
		describe "after saving user" do
			before {click_button submit}
			let(:user) {User.find_by(email: 'user@example.com')}

			#it{should have_link('SignOut')}
			#it{should have_title(user.email)}
		end
	end
end