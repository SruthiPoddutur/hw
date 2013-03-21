class Forum < ActiveRecord::Base
  
  # Associations
  has_many :topics, :dependent => :destroy
  has_many :posts, :through => :topics
  
  # Accessors
  attr_accessible :title, :description, :state, :position
  
  # Scopes
  default_scope :order => 'position ASC'
  scope :recent, where("created_at > ? ", Date.today - 7) 
  
  # Validations
  validates :title,       :presence => true
  validates :description, :presence => true
end