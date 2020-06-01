class User < ActiveRecord::Base
    has_secure_password
    has_many :recipes
    has_many :posts

    def slug
        name.downcase.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        User.all.find { |user| user.slug == slug}
    end
    
end