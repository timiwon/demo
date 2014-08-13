class User < ActiveRecord::Base
	before_save {self.email = email.downcase}
	before_create :create_remember_token

	has_many :microposts, dependent: :destroy

	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed
	
	has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  	has_many :followers, through: :reverse_relationships, source: :follower

	VALID_EMAIL_REGEX = /\A[\w+\-.\d]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: true
	
	has_secure_password
	validates :password, presence: {on: :create}, length: {minimum: 3}

	paginates_per 10

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def feed
	    # This is preliminary. See "Following users" for the full implementation.
	    #Micropost.where("user_id = ?", id)
	    microposts
	end

	def following?(other_user)
	    relationships.find_by(followed_id: other_user.id)
	end

	def follow!(other_user)
		relationships.create!(followed_id: other_user.id)
	end

	def unfollow!(other_user)
	    relationships.find_by(followed_id: other_user.id).destroy
	end

	private
		def create_remember_token
			self.remember_token = User.digest(User.new_remember_token)
		end
end