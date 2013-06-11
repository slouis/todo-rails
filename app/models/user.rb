class User < ActiveRecord::Base
  attr_accessor  :password # DBに存在しないが、getter, setterを生成してくれる
  attr_accessible :email, :username, :password, :password_confirmation
  validates :username, presence: true, uniqueness:true
  validates_confirmation_of :password  
  validates_presence_of :password, :on => :create  
  validates_presence_of :email  
  validates_uniqueness_of :email 
  
  before_save :encrypt_password

  # 1:N
  has_many :lists

  def encrypt_password  
    if password.present?
    	self.password_salt = BCrypt::Engine.generate_salt  
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)  
    end
  end


  def self.authenticate(email, password)  
    user = find_by_email(email)  
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user  
    else  
      nil  
    end  
  end 

end
