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

    it "matches the most general form" do
        subject.detect { |x| x == %w[girl joined boy for food] }.should == %w[girl joined boy for food]
    end
  end
end
