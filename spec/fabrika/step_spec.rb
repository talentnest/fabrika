require "spec_helper"

describe Fabrika::Step do

  let(:process) { Fabrika::Process.new }

  let(:step) { described_class.new(process) }

  describe "#run" do

    subject { step.run }

    after { subject }

    it "calls callbacks and execute" do
      step.should_receive(:callbacks!).with(:before)
      step.should_receive(:execute)
      step.should_receive(:callbacks!).with(:after)
    end

  end

end