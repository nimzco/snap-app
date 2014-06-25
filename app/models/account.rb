class Account < ActiveRecord::Base

RESTRICTED_SUBDOMAINS = %w(www)

has_one :owner, class_name: 'User'
# belongs_to :owner, class_name: 'User'
# has_many :users
validates :owner, presence: true
validates :name, presence: true
validates :subdomain, presence: true,
                       uniqueness: { case_sensitive: false },
                       format: { with: /\A[\w\-]+\Z/i, message: 'contains invalid characters' },
                       exclusion: { in: RESTRICTED_SUBDOMAINS, message: 'restricted' }
 
accepts_nested_attributes_for :owner

before_validation :downcase_subdomain

def self.current_id=(id)
  Thread.current[:account_id] = id
end

def self.current_id
  Thread.current[:account_id]
end

private
   def downcase_subdomain
     self.subdomain = subdomain.try(:downcase)
   end

end
