class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook, :twitter] 

  has_many :posts
  has_many :friendships
  has_many :follows, through: :friendships, source: :usuario
  has_many :followers_friendships, class_name: "Friendship", foreign_key: "usuario_id" 
  has_many :followers, through: :followers_friendships, source: :friend

  def follow!(amigo_id)
    friendships.create!(friend_id: amigo_id)
  end

  def can_follow?(amigo_id)
    not amigo_id == self.id or friendships.where(friend_id: amigo_id).size > 0
  end
    
  def email_required?
    false
  end



  validates :username, presence: true, uniqueness: true,
            length: {minimum: 5, maximum: 20, too_short: "Debe tener al menos 5 caracteres", too_long: "Debe tener como máximo 20 caracteres"}, #in: 5..20
            format: {with: /([A-Za-z0-9\-\_]+)/, message: "Username solo puede contener letras, números y guiones"}#Expresión regular solo para letras, número, guión y guión bajo
  
  #validate :validacion_personalizada, on: :create

  def self.find_or_create_by_omniauth(auth)
  	usuario = Usuario.where(provider: auth[:provider], uid: auth[:uid]).first

  	unless usuario
  		usuario = Usuario.create(
  			nombre: auth[:nombre],
  			apellido: auth[:apellido],
  			username: auth[:username],
  			email: auth[:email],
  			uid: auth[:uid],
  			provider: auth[:provider],
  			password: Devise.friendly_token[0,20]
  		)
  	end
    usuario
  end

  #private
  #def validacion_personalizada
  #  if true

  #  else
  #    errors.add(:username, "Tu username no es válido")
  #  end
  #end

end
