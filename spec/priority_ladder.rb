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

    it "matches with 1 generalization" do
        subject.detect { |x| x == %w[mary joined bob for food] }.should == %w[mary joined bob for food]
        subject.detect { |x| x == %w[girl joined bob for icecream] }.should == %w[girl joined bob for icecream]
        subject.detect { |x| x == %w[mary joined boy for icecream] }.should == %w[mary joined boy for icecream]
    end
  end
end
