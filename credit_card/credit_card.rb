class Fixnum
  def to_digits
    self.to_s.split(//).map(&:to_i)
  end
end

class CreditCard
  attr_reader :name, :card_number, :balance, :limit

  def initialize(name, card_number, dollar_limit)
    @name = name
    @card_number = card_number
    @limit = dollar_limit
    @balance = 0
  end

  def valid?
    self.class.validate_number(@card_number)
  end

  def self.validate_number(number)
    digits = number.to_digits
    digits.reverse!
    products = alternate_doubles digits
    sum = sum_digits products
    checksum = sum % 10
    checksum == 0
  end

  private
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
