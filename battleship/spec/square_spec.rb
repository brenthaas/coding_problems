require_relative '../square.rb'
require_relative '../ship.rb'

describe Square do
  describe "#empty?" do
    it "starts out true" do
      expect(subject.empty?).to be true
    end
  end

  describe "#shoot!" do
    it "makes the square not empty" do
      expect{subject.shoot!}.to change(subject, :empty?).to false
    end

    it "raises an error if already shot" do
      subject.shoot!
      expect{subject.shoot!}.to raise_error(Square::AlreadyShotError)
    end
  end

  describe "#add_ship" do
    let(:ship) { Ship.new(2) }

    it "sets the boat attribute" do
      expect{subject.add_ship(ship)}.to change(subject, :ship).from(nil).to(ship)
    end
  end

  context "when a ship is present" do
    let(:ship) { Ship.new(2) }
    before { subject.add_ship(ship) }

    it "hits the ship" do
      expect(ship).to receive(:hit!)
      subject.shoot!
    end
  end
end
