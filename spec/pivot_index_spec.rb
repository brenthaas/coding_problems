require_relative '../pivot_index.rb'

describe Array do
  describe "#pivot_index" do
    specify "an empty array has no pivot" do
      [].pivot_index.should == -1
    end
    specify "an array with 1 element has a pivot of 0" do
      [0].pivot_index.should == 0
    end
    specify { [0, 0, 0].pivot_index.should == 0 }
    specify { [1, 4, 6, 3, 2].pivot_index.should == 2 }
    specify { [-5, 5, 0, 8, -8].pivot_index.should == 2}
    specify { [-3, -6, -3].pivot_index.should == 1 }
    specify { [-3, 8, 3, 5].pivot_index.should == 2 }
    specify { [8, 4].pivot_index.should == -1 }
  end
  describe "#get_tail_sums" do
    specify "sums up items to the end of the array" do
      [1, 1, 1, 1].send(:get_tail_sums).should == [4, 3, 2, 1]
    end
  end
end
