require_relative './credit_card'

class Bank
  def initialize
    @accounts = {}
  end

  def add_account(name, card)
    @accounts[name] = card
  end

  def accounts
    account_strings = []
    @accounts.each do |name, card|
      account_strings << "#{name}: #{card.balance_string}"
    end
    account_strings.sort
  end

  def charge_account(name, amount)
    return unless @accounts[name]
    @accounts[name].charge amount
  end

  def credit_account(name, amount)
    return unless @accounts[name]
    @accounts[name].credit amount
  end
end
