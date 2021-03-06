require_relative '../credit_card'

describe CreditCard do
  let(:card) {CreditCard.new(1234567812345670, 100)}

  it "starts with a balance of 0" do
    card.balance.should == 0
  end

  describe "#valid?" do
    it "validates the card number against luhn 10" do
      CreditCard.should_receive(:passes_luhn_10?).with(card.card_number)
      card.valid?
    end
  end

  describe "#balance_string" do
    it "gives the balance with a dollar sign" do
      card.balance_string.should == "$#{card.balance}"
    end
    it "gives the balance as 'error' if the card is invalid" do
      card.stub(:valid?).and_return false
      card.balance_string.should == "error"
    end
  end

  describe "#charge" do
    it "adds the amount to the balance" do
      amount = 10
      expect{card.charge amount}.to change{card.balance}.by amount
    end
    context "does NOT change the balance" do
      specify "when the card is at its limit" do
        too_much = card.limit + 1
        expect{card.charge too_much}.to_not change{card.balance}
      end
      specify "when the card number is invalid" do
        CreditCard.stub(:passes_luhn_10?).and_return false
        expect{card.charge 1}.to_not change{card.balance}
      end
    end
  end

  describe "#credit" do
    it "reduces the balance" do
      expect{card.credit 10}.to change{card.balance}.from(0).to(-10)
    end
    it "can't be tricked into exceeding limit" do
      too_much = (card.limit + 1)
      expect{card.credit -too_much}.to_not change{card.balance}
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
