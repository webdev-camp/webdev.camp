class User < ActiveRecord::Base

  enum role: [:user, :teacher, :admin]

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  def resume
    Resume.find_or_create_by( :user_id => self.id)
  end

  def application
    Apply.where(user_id: self.id ).first
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
