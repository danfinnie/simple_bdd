require 'spec_helper'

describe SimpleBdd::PriorityLadder do
  let(:subject) { SimpleBdd::PriorityLadder.new(arr, names) }

  let(:arr) { %w[mary joined bob for icecream] }

  describe "#detect" do

    context "lowercase names" do
        let(:names) { {
          mary: "girl",
          bob: "boy",
          icecream: "food"
        } }

        it "can handle not matching anything" do
            subject.detect { false }.should be_nil
        end

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

        it "matches with 2 generalizations" do
            subject.detect { |x| x == %w[mary joined boy for food] }.should == %w[mary joined boy for food]
            subject.detect { |x| x == %w[girl joined boy for icecream] }.should == %w[girl joined boy for icecream]
            subject.detect { |x| x == %w[girl joined bob for food] }.should == %w[girl joined bob for food]
        end

        it "matches in priority order" do
            subject.detect { |x| x[0] == "mary" }.should == arr
            subject.detect { |x| x[2] == "bob" }.should == arr
            subject.detect { |x| x[-1] == "icecream" }.should == arr
            subject.detect { |x| x[0] == "girl" && x[-1] == "food" }.should == %w[girl joined bob for food]
        end
    end

  end
end
