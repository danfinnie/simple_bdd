require 'spec_helper'

describe SimpleBdd::PriorityLadder do
  let(:subject) { SimpleBdd::PriorityLadder.new(arr, names) }

  let(:arr) { %w[mary joined bob for icecream] }
  let(:names) { {
    mary: "girl",
    bob: "boy",
    icecream: "food"
  } }

  describe "#detect" do
    it "matches the original" do
        subject.detect { |x| x == arr }.should == arr
    end
  end
end
