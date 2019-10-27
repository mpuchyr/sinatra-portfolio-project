class User < ActiveRecord::Base
    has_secure_password
    has_many :legos

    validates :username, presence: true
    validates :username, uniqueness: true
    validates :password, presence: true
end