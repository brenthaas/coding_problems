require_relative '../mine_exploder'

describe "mine_exploder" do
  subject {MineExploder.new}

  describe "#add_mine" do
    it "adds a mine to the mine list" do
      expect{subject.add_mine(1, 1, 1)}.to change{subject.mines.count}.by(1)
    end
  end
  describe "#biggest_explosions" do
    it "returns nil if there are no mines" do
      expect(subject.biggest_explosions).to be_nil
    end
    it "returns the only mine if there's only one" do
      subject.add_mine(1,1,1)
      subject.biggest_explosions[:mines].should == [[1,1]]
    end
  end
end
