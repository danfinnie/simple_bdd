require 'spec_helper'

class SimpleBddExample
  include SimpleBdd
end

describe SimpleBddExample do

  let(:subject) { SimpleBddExample.new }

  describe "#given, #when, #then, #and" do
    ["given", "when", "then", "and", "Given", "When", "Then", "And"].each do |method|
      it "calls the method after translating the string" do
        subject.should_receive(:something)
        subject.send(method, "something")
      end
    end
  end

  describe "#methodize" do
    it "removes special chars" do
        subject.send(:methodize, "bond, james bond").should == "bond_james_bond"
    end

    it "converts to lower case" do
        subject.send(:methodize, "HELLO WORLD").should == "hello_world"
    end
  end
end
