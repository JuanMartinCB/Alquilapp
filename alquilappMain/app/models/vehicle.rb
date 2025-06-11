class Vehicle < ApplicationRecord
  include AASM

  has_many :cooldowns, dependent: :destroy

  validates :did, presence: {message: "Campo Obligatorio"}, uniqueness: {message: "Ya existe un vehiculo con ese numero de identificacion"}, numericality: { only_integer: true, greater_than_or_equal_to: 0, message: "Solo puede haber numeros Positivos" }
  validates :patent, presence: {message: "Campo Obligatorio"}
  validates :patent, uniqueness: {message: "Patente ya registrada"}
  validates :brand, presence: {message: "Campo Obligatorio"}
  validates :model, presence: {message: "Campo Obligatorio"}
  validates :year, presence: {message: "Campo Obligatorio"}, numericality: { only_integer: true ,
            greater_than_or_equal_to: 1980, message: "Solo anios posteriores a 1980" }
  #validates :location, presence: {message: "Campo Obligatorio" }
  validates :image, size: { less_than: 1.megabytes, message: "Debe ser menor a 1 MB" }, content_type: { in: ['image/png', 'image/jpg', 'image/jpeg'], message: "Solo se permiten imagenes" }
  validates :image, presence: {message: "Campo Obligatorio"}, on: :create
  
  validates :vehicle_type, presence: {message: "Campo Obligatorio"}
  Types= ["Auto", "Camioneta", "Camion", "Utilitario"]
  Brands=["Toyota","Fiat", "Volkswagen", "Renault", "Peugeot", "Ford", "Citroën", "Nissan", "Jeep"]
  Features=["2 Puertas","4 Puertas","Aire Acondicionado","Air Bag","ABS","1 Valija Grande","2 Valijas Pequeñas","2 Personas", "4 Personas", "5 Personas", "8 Personas", "Alarma", "Levanta Vidrios Electrico", "Cierre Centralizado", "4x4","Automatico","Electrico","Hibrido","Manual","Diesel","Nafta","GNC",]

  validates :features, presence: {message: "Campo Obligatorio (al menos 1)"}, length: { minimum: 1 }

  has_many :rentals
  has_one_attached :image

  has_many :incidents
  
  aasm column: 'state' do
    state :draft, initial: true
    state :published
    state :in_use
    state :blocked

    event :publish do
      transitions from: :draft, to: :published
      transitions from: :blocked, to: :published
    end

    event :use do
      transitions from: :published, to: :in_use
      transitions from: :in_use, to: :published
    end

    event :block do
      transitions from: :published, to: :blocked
    end

  end

  def published
    Vehiculo.where(state: 'published')
  end
  
  def in_use?
    if self.state == 'in_use'
      return true
    else
      return false
    end
  end

  def blocked?
    if self.state == 'blocked'
      return true
    else
      return false
    end
  end

  def draft?
    if self.state == 'blocked'
      return true
    else
      return false
    end
  end

  def published?
    if self.state == 'published'
      return true
    else
      return false
    end
  end

  def full_name 
    "#{self.brand} #{self.model} #{self.year}"
  end

  #create a def method who return he state of the vehicle
  def get_state
    case self.state
    when "draft"
      "Borrador"
    when "published"
      "Publicado"
    when "in_use"
      "En Uso"
    when "blocked"
      "Bloqueado"
    end
  end

 
  def disponible?(user)
    @c = Cooldown.where(user_id: user.id, vehicle_id: self.id)
    if @c.empty?
      return true
    else
      #check @c, if any of the cooldowns is less than 3 hous ago, return false
      @c.each do |c|
        if c.created_at > 3.hours.ago
          return false
        end
      end
    end
  end

  #validates that the vehicle is not nafta, gnc, diesel or hybrid at the same time
  
  validate :ngdh

  def ngdh
    case 
    when self.features.include?("Diesel") && self.features.include?("Nafta") && self.features.include?("GNC") && self.features.include?("Hibrido")
      errors.add(:features, "No puede ser Diesel, Nafta, GNC y Hibrido al mismo tiempo")
    when self.features.include?("Diesel") && self.features.include?("Nafta") && self.features.include?("GNC")
      errors.add(:features, "No puede ser Diesel, Nafta y GNC al mismo tiempo")
    when self.features.include?("Diesel") && self.features.include?("Nafta") && self.features.include?("Hibrido")
      errors.add(:features, "No puede ser Diesel, Nafta y Hibrido al mismo tiempo")
    when self.features.include?("Diesel") && self.features.include?("GNC") && self.features.include?("Hibrido")
      errors.add(:features, "No puede ser Diesel, GNC y Hibrido al mismo tiempo")
    when self.features.include?("Nafta") && self.features.include?("GNC") && self.features.include?("Hibrido")
      errors.add(:features, "No puede ser Nafta, GNC y Hibrido al mismo tiempo")
    when self.features.include?("Diesel") && self.features.include?("Nafta")
      errors.add(:features, "No puede ser Diesel y Nafta al mismo tiempo")
    when self.features.include?("Diesel") && self.features.include?("GNC")
      errors.add(:features, "No puede ser Diesel y GNC al mismo tiempo")
    when self.features.include?("Diesel") && self.features.include?("Hibrido")
      errors.add(:features, "No puede ser Diesel y Hibrido al mismo tiempo")
    when self.features.include?("Nafta") && self.features.include?("GNC")
      errors.add(:features, "No puede ser Nafta y GNC al mismo tiempo")
    when self.features.include?("Nafta") && self.features.include?("Hibrido")
      errors.add(:features, "No puede ser Nafta y Hibrido al mismo tiempo")
    when self.features.include?("GNC") && self.features.include?("Hibrido")
      errors.add(:features, "No puede ser GNC y Hibrido al mismo tiempo")
    end
  end


end
