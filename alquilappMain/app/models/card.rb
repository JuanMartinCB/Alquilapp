class Card < ApplicationRecord
    belongs_to :wallet
    
    validates :number, presence: { message: "Campo obligatorio" }
    validate :non_repeated_card
    validates :name, presence: { message: "Campo obligatorio" }, length: { maximum: 50, message: "Máximo 50 caracteres" }
    validates :expiration_month, presence: { message: "Campo obligatorio" }
    validates :expiration_year, presence: { message: "Campo obligatorio" }
    validates :cvc, presence: { message: "Campo obligatorio" }, length: { is: 3, message: "La longitud del CVC debe ser de 3 caracteres" }
    validates :wallet_id, presence: true
    validate :expiration_date_is_valid

    CTYPES = [:Debito, :Credito]
    validates :ctype, presence: { message: "Campo obligatorio" }
    
    validates :number, length: { is: 16, message: "El numero debe contener 16 digitos" }, numericality: { only_integer: true, message: "Número de tarjeta no válido" }
    validates :expiration_year, length: { is: 4, message: "Año de expiración no válido" }

    enum Company: [:Visa, :MasterCard, :AmericanExpress, :DinersClub, :JCB, :Discover, :Unknown]
  
    def card_type(num)
         
        n=num.to_s[0..3].to_i
        if n>=4000 && n<5000
            return Card.Companies[:Visa]
        elsif n>=5100 && n<5600
            return Card.Companies[:MasterCard]
        elsif n>=3400 && n<3500
            return Card.Companies[:AmericanExpress]
        elsif n>=3000 && n<3100
            return Card.Companies[:DinersClub]
        elsif n>=3528 && n<3589
            return  Card.Companies[:JCB]
        elsif n>=6011 && n<7000
            return Card.Companies[:Discover]
        else
            return Card.Companies[:Unknown]
        end
    end

    def card_company(num)
         
        n=num.to_s[0..3].to_i
        if n>=4000 && n<5000
            return "Visa"
        elsif n>=5100 && n<5600
            return "MasterCard"
        elsif n>=3400 && n<3500
            return "AmericanExpress"
        elsif n>=3000 && n<3100
            return "DinersClub"
        elsif n>=3528 && n<3589
            return  "JCB"
        elsif n>=6011 && n<7000
            return "Discover"
        else
            return "Unknown"
        end
    end
    
    def expiration_date_is_valid
        if expiration_year == Time.now.year
            if expiration_month < Time.now.month
                errors.add(:expiration_month, "La tarjeta ya expiró")
            end
        else
            if expiration_year != nil && expiration_year < Time.now.year
                errors.add(:expiration_year, "La tarjeta ya expiró")
            end
        end
    end

    def non_repeated_card
        if Card.where(number: number, wallet_id: wallet_id).exists?
            errors.add(:number, "Tarjeta ya Registrada")
        end
    end

    def last_four_digits
        number.to_s[-4..-1].to_i
    end
end
