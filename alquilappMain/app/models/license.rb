class License < ApplicationRecord
    belongs_to :user
    has_one_attached :image
    validates :image, presence: {message: "Campo Obligatorio"}, size: { less_than: 1.megabytes, message: "Debe ser menor a 1 MB" }, content_type: { in: ['image/png', 'image/jpg', 'image/jpeg'], message: "Solo se permiten imagenes" }
    
    #define a mehod that returns true if the license is authorized
    def authorized?
        self.authorized
    end

end


