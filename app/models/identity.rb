class Identity < OmniAuth::Identity::Models::ActiveRecord
	attr_accessible :name , :email , :password , :password_confirmation, :confirmation_token, :confirmed_at, :verified
validates :email, :uniqueness => { :case_sensitive => false }
end
