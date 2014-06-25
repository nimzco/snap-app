class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable  
  acts_as_tenant :account
  validates :lastname, presence: true, allow_nil: false
  validates :firstname, presence: true, allow_nil: false
  validates :password, presence: true, allow_nil: false
  validates :email, presence: true, allow_nil: false #uniqueness: true,

  
  def to_s
  	"#{firstname} #{lastname} (#{email})"
  end       
end
