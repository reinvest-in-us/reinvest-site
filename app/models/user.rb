class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :registerable, :confirmable, :recoverable, and :omniauthable
  devise :database_authenticatable, :rememberable, :lockable, :timeoutable, :trackable, :validatable
end
