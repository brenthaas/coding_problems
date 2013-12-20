require_relative '../menu'

describe Menu do
  let(:simple) { "1, 4.00, ham_sandwich
                  1, 8.00, burrito
                  2, 5.00, ham_sandwich
                  2, 6.50, burrito"
                }

  describe "input" do
    it "requires a filename be given at command line" do
      `ruby ./menu.rb`.should == "Please provide a file\n"
    end
  end
end