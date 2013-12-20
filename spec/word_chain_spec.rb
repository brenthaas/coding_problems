require_relative '../word_chain'

describe "String#chains_to?" do
	describe "happy path" do
		it "accepts the same word" do
			"cat".chains_to?("cat").should be true
		end
		it "accepts single letter difference" do
			"dog".chains_to?("doe").should be true
		end
		it "accepts a single letter difference at the end" do
			"boa".chains_to?("boat").should == true
		end
	end
	describe "sad path" do
		it "doesn't accept two letter differences (same length)" do
			"bang".chains_to?("bent").should_not == true
		end
		it "doesn't accept long differences" do
			"fall".chains_to?("fallen").should_not == true
		end
		it "doesn't accept close differences" do
			"carp".chains_to?("corps").should_not == true
			"corps".chains_to?("carp").should_not == true
		end
	end
end
