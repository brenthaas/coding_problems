class Fixnum
  def to_digits
    self.to_s.split(//).map(&:to_i)
  end
end

class CreditCard
  attr_reader :card_number, :balance, :limit

  def initialize(card_number, dollar_limit)
    @card_number = card_number
    @limit = dollar_limit
    @balance = 0
  end

  def balance_string
    if valid?
      "$#{balance}"
    else
      "error"
    end
  end

  def charge(amount)
    if (valid? && charge_within_limit?(amount))
      @balance += amount
    end
  end

  def credit(amount)
    charge -amount
  end

  def valid?
    self.class.passes_luhn_10? @card_number
  end

  def self.passes_luhn_10? number
    digits = number.to_digits
    products = alternate_doubles digits.reverse
    sum = sum_digits products
    checksum = sum % 10
    checksum == 0
  end

  private
    def charge_within_limit?(amount)
      (@balance + amount) <= @limit
    end

    def self.alternate_doubles numbers
      count = 0
      numbers.map do |num|
        multiplier = (count % 2) + 1
        count += 1
        num * multiplier
      end
    end

    def self.sum_digits numbers
      numbers.map(&:to_digits).flatten.reduce(&:+)
    end
end
