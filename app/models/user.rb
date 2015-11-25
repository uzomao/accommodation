class User < ActiveRecord::Base
  has_many :listings, dependent: :destroy

  has_many :comments, dependent: :destroy

  serialize :favourites,Array
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_confirmation_of :password_confirmation

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
end
