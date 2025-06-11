class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  # validates :phone, presence: true
  validates :dni , presence: {message: "Campo Obligatorio"}, uniqueness: {message: "Ya existe un usuario con ese numero de DNI"}
  validates :name, presence: true, format: {with: /\A[a-zA-Z]+\z/, message: "Solo se permiten letras"}
  validates :surname, presence: true, format: {with: /\A[a-zA-Z]+\z/, message: "Solo se permiten letras"}
  # validates :phone, presence: {message: "Campo Obligatorio"}, phone: {possible: true, types: [:mobile], countries: [:ar] }
  validates :phone, presence: {message: "Campo Obligatorio"}, uniqueness: {message: "Ya existe un usuario con ese numero de telefono"}, numericality: { only_integer: true, message: "Solo se permiten numeros" }

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6, message: "Debe tener al menos 6 caracteres" }, on: :create 
  validates :password_confirmation, presence: true ,length: { minimum: 6, message: "Debe tener al menos 6 caracteres" }, on: :create  
  #validate that phone only ontains numbers
  # NO ANDA CON OLVIDAR CONTRASEÑA validates :phone, format: { with: /\A[0-9]+\z/, message: "Solo puede haber numeros" }
  #add the country code to number before save
  # NO ANDA CON OLVIDAR CONTRASEÑA before_save :add_country_code
  
  def add_country_code
    self.phone = Phonelib.parse(self.phone).full_e164
  end
  
  #User wallet
  has_one :wallet, dependent: :destroy
  #User license association
  has_one :license
  
  has_many :rentals

  has_many :incidents

  has_many :cooldowns, dependent: :destroy
  
  def admin?
    admin_role
  end

  def supervisor?
    supervisor_role
  end
  
  validate :only_one_role 

  def only_one_role
    if admin_role && supervisor_role
      errors.add(:admin_role, "Solo puede tener un rol")
    end
    if admin_role && user_role
      errors.add(:admin_role, "Solo puede tener un rol")
    end
    if supervisor_role && user_role
      errors.add(:supervisor_role, "Solo puede tener un rol")
    end
  end

  scope :active, -> { where(state: 0) }

  def active_for_authentication?
    #remember to call the super
    #then put our own check to determine "active" state using 
    #our own "is_active" column
    super and self.state == 0

  end
  #define a method thar returns true if the user has a licences attached
  def license?
    self.license.present?
  end
 
  def full_name 
    "#{name} #{surname}"

  end
  
end
