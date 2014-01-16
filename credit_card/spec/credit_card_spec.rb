require_relative '../credit_card'

describe CreditCard do
  describe "class methods" do
    describe "#validate_number" do
      context "valid numbers" do
        valid_numbers = [4111111111111111, 5454545454545454]
        valid_numbers.each do |num|
          it "#{num}" do
            CreditCard.validate_number(num).should be_true
          end
        end
      end
      context "invalid numbers" do
        invalid_numbers = [4111111111111112, 1234567890123456]
        invalid_numbers.each do |num|
          it "#{num}" do
            CreditCard.validate_number(num).should be_false
          end
        end
      end
    end
  end

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


describe String do
  describe "#dollar_value" do
    it "converts $<number> to an integer" do
      "$100".dollar_value.should == 100
    end
    it "also works for numbers without a dollar sign" do
      "50".dollar_value.should == 50
    end
    specify "invalid input evaluates to 0" do
      "invalid".dollar_value.should == 0
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
