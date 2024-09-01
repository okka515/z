require 'bundler/setup'
require 'bcrypt'
Bundler.require

ActiveRecord::Base.establish_connection

class User < ActiveRecord::Base
    has_secure_password
    validates :name, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    has_many :posts
    has_many :comments
end

class Post < ActiveRecord::Base
    belongs_to :user
    has_many :comments
end

class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :post
end