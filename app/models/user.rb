class User < ActiveRecord::Base
  has_merit

    acts_as_voter 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  extend FriendlyId
    friendly_id :username, use: [:slugged]

  devise :database_authenticatable, :registerable,  
    :recoverable, :rememberable, :trackable, :validatable

  before_save { |user| user.username = user.username.downcase }
  before_save { self.email = email.downcase }
  has_many :posts, :dependent => :delete_all
  has_many :comments, :through => :posts

  validates :username, :presence => true, :uniqueness => true

  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  validate :validate_username

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end
end
