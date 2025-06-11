class Incident < ApplicationRecord
    #validate description presence
    validates :description, presence: {message: "Campo Obligatorio"}
    validates :image, size: { less_than: 1.megabytes, message: "Debe ser menor a 1 MB" }, content_type: { in: ['image/png', 'image/jpg', 'image/jpeg'], message: "Solo se permiten imagenes" }
    

    has_one_attached :image

end
