require 'spec_helper'

describe SimpleBdd::PriorityLadder do
  let(:subject) { SimpleBdd::PriorityLadder.new(terms, names) }

  let(:names) { {
    mary: "girl",
    bob: "boy",
    icecream: "food"
  } }

  describe "#detect" do

    context "lowercase terms" do

        let(:terms) { %w[mary joined bob for icecream] }

        it "can handle not matching anything" do
            subject.detect { false }.should be_nil
        end

        it "matches the original" do
            subject.detect { |x| x == terms }.should == terms
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
            subject.detect { |x| x[0] == "mary" }.should == terms
            subject.detect { |x| x[2] == "bob" }.should == terms
            subject.detect { |x| x[-1] == "icecream" }.should == terms
            subject.detect { |x| x[0] == "girl" && x[-1] == "food" }.should == %w[girl joined bob for food]
        end
    end

    context "toggle case array" do
        let(:terms) { %w[MARY joined bOb for ICEcream] }

        it "performs the generalizations and preserves case" do
            subject.detect { |x| x == %w[girl joined boy for ICEcream] }.should == %w[girl joined boy for ICEcream]
        end
    end
  end
end
