require_relative '../ship'

describe Ship do
  let(:size) { 2 }

  subject{ described_class.new(size) }

  describe "#sunk?" do
    it "starts out as not sunk" do
      expect(subject.sunk?).to be false
    end
  end

  describe "#hit!" do
    it "sinks a ship" do
      size.times { subject.hit! }
      expect(subject).to be_sunk
    end

    it "doesn't continue to hit a sunk ship" do
      (size + 1).times { subject.hit! }
      expect(subject).to be_sunk
    end
  end
end
