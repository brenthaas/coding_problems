require_relative '../pig_latin'

describe PigLatin do
  it "responds with 'ellohay' when given 'hello'" do
    require 'ruby-debug'; debugger
    PigLatin.translate("hello").should == "ellohay"
  end

  it "says 'ellohay orldway' when given 'hello world'" do
    PigLatin.translate("hello world").should == "ellohay orldway"
  end

  it "says 'Ellohay Orldway' when given 'Hello World'" do
    PigLatin.translate("Hello World").should == "Ellohay Orldway"
  end

  it "says 'Ellohay, orldway!' when given 'Hello, world!'" do
    PigLatin.translate("Hello, world!").should.== "Ellohay, orldway!"
  end

  it "says 'eatay applesay' when given 'eat apples'" do
    PigLatin.translate("eat apples").should == "eatay applesay"
  end

  it "says 'ownbray oxfay' when given 'brown fox'" do
    PigLatin.translate("brown fox").should == "ownbray oxfay"
  end

  it "says 'ickquay ownbray oxfay' when given 'quick brown fox'" do
    PigLatin.translate('quick brown fox').should == 'ickquay ownbray oxfay'
  end
end