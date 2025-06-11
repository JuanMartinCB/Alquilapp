class Wtransaction < ApplicationRecord
    belongs_to :wallet
    has_one :ticket, dependent: :destroy
    validates :entry, presence: { message: "Debe ingresar un monto" }
    #validates :entry, numericality: { greater_than: 0, message: "El monto debe ser mayor a 0" }
    
    validate :entry_greater_than_zero
    
    def entry_greater_than_zero
        if self.entry == nil 
            errors.add(:entry, "Debe ingresar un monto")
        else
            if self.entry <= 0 && self.wtype == "Ingreso"
                errors.add(:entry, "El monto debe ser mayor a 0")
            end
        end
    end

    validate :cvc_validation

    def cvc_validation
        if self.wtype == "Ingreso"
            if self.cvc == nil 
                errors.add(:cvc, "Debe ingresar el CVC/CVV")
            else
                if self.cvc != Card.find(self.card_id).cvc
                    errors.add(:cvc, "El CVC/CVV es incorrecto")
                end
            end
        end
    end

end
