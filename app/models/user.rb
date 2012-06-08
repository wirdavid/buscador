class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :username, :name, :type, :status

  validates :username, :presence => true
  validates :name, :presence => true
  validates :type, :presence => true
  validates :status, :presence => true
  # attr_accessible :title, :body
  #
  # relations
  has_many :saved_posts
  has_many :posts_saved, :source => :post, :through => :saved_posts
  
  VISITANTE = 3
  
  def visitante?
    self.type == VISITANTE
  end

  def save_post(post)
  end

  def comment(post,comment)
    post.add_comment(comment)
  end
end
