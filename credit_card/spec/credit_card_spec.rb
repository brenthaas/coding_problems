require_relative '../credit_card'

describe CreditCard do
  let(:valid_card) {CreditCard.new("First Last", 1234567812345670, 100)}

  it "starts with a balance of 0" do
    valid_card.balance.should == 0
  end

  describe "#valid?" do
    it "validates the card number against luhn 10" do
      CreditCard.should_receive(:passes_luhn_10?).with(valid_card.card_number)
      valid_card.valid?
    end
  end
  describe "class methods" do
    describe "passes_luhn_10?" do
      context "valid numbers" do
        valid_numbers = [4111111111111111, 5454545454545454, 49927398716, 1234567812345670]
        valid_numbers.each do |num|
          it "#{num}" do
            CreditCard.passes_luhn_10?(num).should be_true
          end
        end
      end
      context "invalid numbers" do
        invalid_numbers = [4111111111111112, 1234567890123456, 49927398717, 1234567812345678]
        invalid_numbers.each do |num|
          it "#{num}" do
            CreditCard.passes_luhn_10?(num).should be_false
          end
        end
      end
    end
  end

  # These can be removed in theory, but they were helpful
  describe "private methods" do
    describe "#alternate_doubles" do
      it "doubles every 2nd number" do
        CreditCard.alternate_doubles([1, 1, 1, 1]).should == [1, 2, 1, 2]
      end
    end
    describe "#sum_digits" do
      it "sums the numbers" do
        CreditCard.sum_digits([1, 1, 1, 1]).should == 4
      end
      it "sums the digits of a number" do
        CreditCard.sum_digits([12345]).should == 15
      end
    end
  end
end



describe Fixnum do
  describe "#to_digits" do
    it "turns a single digit into an array" do
      3.to_digits.should == [3]
    end
    it "turns a long integer into an array of digits" do
      12345.to_digits.should == [1, 2, 3, 4, 5]
    end
  end
end
