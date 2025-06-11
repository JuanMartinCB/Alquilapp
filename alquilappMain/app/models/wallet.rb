class Wallet < ApplicationRecord
    belongs_to :user
    has_many :card, dependent: :destroy
    has_many :wtransaction

    #Update the balance of the wallet with the entry value of the transaction
    def update_balance(entry)
        self.balance += entry
        self.save
    end
    
end
