class Post < ActiveRecord::Base
  acts_as_votable

  extend FriendlyId
    friendly_id :mejenga, use: [:finders, :slugged]


  belongs_to :user
  has_many :comments, :dependent => :delete_all
  # default_scope { order('cached_votes_score DESC') }
  default_scope { order('created_at DESC') }

  validates :mejenga, presence: true, length: {minimum: 2, maximum: 300}
  validates :descripcion, presence: true, length: {minimum: 2, maximum:2000}
  validates :user_id, presence: true

end
