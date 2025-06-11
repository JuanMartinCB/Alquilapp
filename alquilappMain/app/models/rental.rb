class Rental < ApplicationRecord
    include AASM
    belongs_to :user
    belongs_to :vehicle
    has_one :wtransaction
    aasm column: 'state' do
      state :active, initial: true
      state :overlimit
      state :finished
  
      event :overlimit do
        transitions from: :active, to: :overlimit
      end
  
      event :finish do
        transitions from: :active, to: :finished
        transitions from: :overlimit, to: :finished
      end
    end

    #Custom Validations
    
    validate :enough_balance

    def enough_balance
        if self.user.wallet.balance < (self.hours * 200)
            errors.add(:base, "No tienes suficiente saldo para alquilar este vehículo")
        end
    end


    #Custom Methods

    #create a method that returns the hour when retal was created
    def start_hour
      self.created_at.strftime("%H:%M:%S")
    end
end
