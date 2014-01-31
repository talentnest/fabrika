require "spec_helper"

describe Fabrika::Step do

  let(:process) { Fabrika::Process.new }

  let(:step) { described_class.new(process) }

  describe ".resource" do
    let(:resource_name) { :some_resource }
    let(:instance_value) { "instance value" }
    subject { step.send(resource_name) }

    before do
      step.class.resource resource_name do
        "block response"
      end
    end

    it { should == "block response" }

    context "when instance variable with resource name is defined" do
      before do
        step.instance_variable_set("@#{resource_name}", instance_value)
      end

      it { should == instance_value }
    end

  end

  describe "#run" do

    subject { step.run(args) }

    let(:args) { { some: "arguments" } }

    after { subject }

    it "calls callbacks and execute" do
      step.should_receive(:callbacks!).with(:before)
      step.should_receive(:execute).with(args)
      step.should_receive(:callbacks!).with(:after)
    end

  end

end