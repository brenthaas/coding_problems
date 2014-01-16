require_relative '../bank'

describe Bank do
  let(:bank) {Bank.new}
  let(:card) {CreditCard.new(1236, 10)}
  let(:person) {"Someone"}

  describe "#add_account" do
    it "adds a card to the card list" do
      expect{bank.add_account("someone", card)}.to change{bank.accounts.count}.by 1
    end
  end

  [:charge, :credit].each do |action|
    bank_action = "#{action}_account".to_sym
    describe "##{bank_action}" do
      before(:each) do
        bank.add_account(person, card)
      end
      let(:amount) {1}
      it "#{action}s the account specified" do
        card.should_receive(action).with(amount)
        bank.send(bank_action, person, amount)
      end
      context "when the account does not exist" do
        it "returns nil" do
          bank.send(bank_action, "nobody", amount).should be_nil
        end
        it "does not #{action} any accounts" do
          CreditCard.any_instance.should_not_receive(action)
          bank.send(bank_action, "nobody", amount)
        end
      end
    end
  end
end
