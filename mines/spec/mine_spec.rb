require_relative '../mine'

describe Mine do
  describe "#location" do
    it "gives an array containing the x and y coordinates" do
      mine = Mine.new(4, 10, 20)
      mine.location.should == [4, 10]
    end
  end
  describe "#explodes?" do
    it "explodes itself" do
      mine1 = Mine.new(1, 1, 1)
      mine1.explodes?(mine1).should be_true
    end
    it "explodes a mine within range" do
      mine1 = Mine.new(1, 1, 1)
      mine2 = Mine.new(1, 2, 1)
      mine1.explodes?(mine2).should be_true
    end
    it "does not explode mines out of range" do
      mine1 = Mine.new(1, 1, 1)
      mine2 = Mine.new(2, 2, 1)
      mine1.explodes?(mine2).should be_false
    end
  end
  describe "#affected_mines" do
    it "gets only the directly mines affected" do
      mine1 = Mine.new(1, 1, 1)
      mine2 = Mine.new(1, 2, 1)
      mine3 = Mine.new(4, 4, 1)
      mine1.affected_mines([mine1, mine2, mine3]).should == [mine1, mine2]
    end
  end
end
