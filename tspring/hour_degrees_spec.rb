require_relative 'hour_degrees'

describe HourDegrees do
  it "works for 4:00" do
    expect(described_class.time_degrees(4, 0)).to eq 120
  end

  it "works for 12:20" do
    expect(described_class.time_degrees(12, 20)).to eq 110
  end

  it "works for 2:45" do
    expect(described_class.time_degrees(2, 45)).to eq 187.5
  end

  it "works for 12:00" do
    expect(described_class.time_degrees(12, 00)).to eq 0
  end
end
