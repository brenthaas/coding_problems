require_relative '../board'
require_relative '../ship'

describe Board do
  let(:width) { 10 }
  let(:height) { 10 }

  subject { described_class.new(width, height) }

  it "initializes a 2D array called squares" do
    board = Board.new(width, height)
    expect(board.squares.size).to eq width
    expect(board.squares[0].size).to eq height
  end

  describe "#place_ship" do
    let(:ship_size) { 2 }
    let(:ship) { Ship.new(ship_size) }
    let(:direction) { 'vertical' }

    it "adds the same ship to multiple squares" do
      expect(subject.squares[0][0]).to receive(:add_ship).with(ship)
      expect(subject.squares[1][0]).to receive(:add_ship).with(ship)
      subject.place_ship(ship: ship, x: 0, y: 0, direction: direction)
    end

    it "does not allow ships to be overlapping" do
      other_ship = Ship.new(ship_size)
      subject.place_ship(ship: ship, x: 0, y: 0, direction: direction)
      expect{
        subject.place_ship(ship: other_ship, x: 0, y: 1, direction: direction)
      }.to raise_error(Board::ShipPlacementError)
    end

    it "does not allow ships to go off of the board" do
      expect {
        subject.place_ship(ship: ship, x: height-1, y: width-1, direction: direction)
      }.to raise_error(Board::ShipPlacementError)
    end

    it "does not allow the same ship to be placed twice" do
      subject.place_ship(ship: ship, x: 0, y: 0, direction: direction)
      expect{
        subject.place_ship(ship: ship, x: 1, y: 0, direction: direction)
      }.to raise_error(Board::ShipPlacementError)
    end
  end

  describe "#fire!" do
    context "on a non-existant square" do
      it "raises an exception" do
        expect {
          subject.fire!(x: width+1, y: height)
        }.to raise_error(Board::LocationError)
      end
    end

    context "on the same square twice" do
      it "raises an exception" do
        subject.fire!(x: 0, y: 0)
        expect {
          subject.fire!(x: 0, y: 0)
        }.to raise_error(Board::LocationError)
      end
    end

    context "on an empty square" do
      it "returns :miss" do
        expect(subject.fire!(x: 0, y: 0)).to eq :miss
      end
    end

    context "on an occupied square" do
      let(:ship) { Ship.new(2) }

      before do
        subject.place_ship(ship: ship, x: 0, y: 0, direction: 'vertical')
      end

      context "before the ship is sunk" do
        it "returns :hit" do
          expect(subject.fire!(x: 0, y: 0)).to eq :hit
        end
      end

      context "when sinking a ship" do
        let(:other_x) { 1 }
        let(:other_y) { 0 }
        let(:other_ship) { Ship.new(1) }

        before do
          subject.place_ship(ship: other_ship,
                             x: other_x,
                             y: other_y,
                             direction: 'vertical')
          subject.fire!(x:0, y: 0)
        end

        context "with more ships left" do
          it "returns :sunk" do
            expect(subject.fire!(x: 0, y: 1)).to eq :sunk
          end
        end

        context "with all other ships sunk" do
          before { subject.fire!(x: other_x, y: other_y) }

          it "retuns :win" do
            expect(subject.fire!(x: 0, y: 1)).to eq :win
          end
        end
      end
    end
  end
end
