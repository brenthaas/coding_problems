require_relative '../balance_array'

describe BalanceArray do
	describe "#balance" do
		context "success" do
			it "finds an easy balance point" do
				BalanceArray.balance([1, 2, 3, 3, 2, 1]).should == 2
			end

			it "accepts negative numbers" do
				BalanceArray.balance([-9, 5, -2, -2, 5, -9]).should == 2
			end

			it "can handle a small array" do
				BalanceArray.balance([1, 1]).should == 0
			end
		end

		context "failure" do
			it "does not accept arrays that are too short" do
				BalanceArray.balance([0]).should be nil
			end

			it "accepts defeat if no balance point found" do
				BalanceArray.balance([1, 2, 3, 4, 5]).should be nil
			end
		end
	end
end