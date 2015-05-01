require_relative '../change'


describe Change do
  describe "#get_change" do
    it "gets exactly one quarter" do
      expect(subject.get_change(25)).to eq(
        {quarters: 1, dimes: 0, nickles: 0, pennies: 0}
      )
    end

    it "gets exactly one dime" do
      expect(subject.get_change(10)).to eq(
        {quarters: 0, dimes: 1, nickles: 0, pennies: 0}
      )
    end

    it "gets exactly one nickle" do
      expect(subject.get_change(5)).to eq(
        {quarters: 0, dimes: 0, nickles: 1, pennies: 0}
      )
    end

    it "works for 41 cents" do
      expect(subject.get_change(41)).to eq(
        {quarters: 1, dimes: 1, nickles: 1, pennies: 1}
      )
    end

    it "works for no money" do
      expect(subject.get_change(0)).to eq(
        {quarters: 0, dimes: 0, nickles: 0, pennies: 0}
      )
    end

  end
end
