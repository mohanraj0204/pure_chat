class User < ApplicationRecord
	before_create :create_token
	before_save {email.downcase!}

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
	validates :password, presence: true, length: {minimum: 6,maximum: 15}

	has_secure_password

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def User.digest(token)
		Digest::SHA1::hexdigest(token.to_s)
	end
	private
		def create_token
			self.token = User.digest(User.new_token)
		end
end
