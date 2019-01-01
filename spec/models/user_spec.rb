require 'spec_helper'
RSpec.describe User, type: :model do
	before do
		@user = User.new(email:"user@gmail.com", password:"password", password_confirmation: "password")
	end

	subject{@user}

	it {should respond_to(:email)}
	it {should respond_to(:password_digest)}
	it {should respond_to(:password)}
	it {should respond_to(:password_confirmation)}
	it {should respond_to(:token)}
	it {should respond_to(:authenticate)}

	it {should be_valid}

	describe "when email is not present" do
		before{@user.email = " "}
		it {should_not be_valid}
	end

	describe "when password is not present" do
		before do
			@user.password = " "
			@user.password_confirmation = " "
		end
		it{should_not be_valid}
	end

	describe "Password not match" do
		before{@user.password_confirmation = "mismatch"}
		it {should_not be_valid}
	end

	describe "Authentication" do
		before {@user.save}
		#its(:token){should_not be_blank}
		it { expect(@user.token).not_to be_blank}
		let(:get_user) {User.find_by(email: @user.email)}

		describe "Signin Success!!" do
			it {should eq get_user.authenticate(@user.password)}
		end

		describe "Signin Failed!!" do
			let(:invalid_user) {get_user.authenticate("invalid")}

			it {should_not eq invalid_user}
			specify {expect(invalid_user).to be_falsey}
		end
	end

	describe "Error!!Email Already Found" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end
		it{should_not be_valid}
	end

	describe "Password have min of 6 char" do
		before{@user.password = "a"*5}
		it{should_not be_valid}
	end
	
	describe "Password have max of 15 char" do
		before{@user.password = "a"*16}
		it{should_not be_valid}
	end	
end