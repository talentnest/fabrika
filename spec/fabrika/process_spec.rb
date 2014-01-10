require "spec_helper"

describe Fabrika::Process do

  let(:process) { Fabrika::Process.new }

  describe "#initialize" do

    subject { described_class.new }

    it "calls #initialize_steps" do
      described_class.any_instance.should_receive(:initialize_steps)
      subject
    end

  end

  describe "#add_step" do
    subject { process.add_step(name, options, &block) }

    let(:name) { :my_step }
    let(:block) { Proc.new { } }

    describe "default config" do

      class Fabrika::Process
        module Steps
          class MyStep < Fabrika::Step; end
        end
      end

      let(:options) { {} }

      it "instantiates Fabrika::Step::MyStep" do
        Fabrika::Process::Steps::MyStep.should_receive(:new).with(process, options)
        subject
      end
    end

    describe ":class_name option" do
      class MyAwesomeStep < Fabrika::Step; end

      let(:options) { { class_name: "MyAwesomeStep" } }

      it "instantiates MyAwesomeStep" do
        MyAwesomeStep.should_receive(:new).with(process, options.except(:class_name) )
        subject
      end
    end

  end

  describe "#(.*)_step magic method" do
    subject { process.custom_step }

    it "calls step with :custom name" do
      process.steps.should_receive(:"[]").with(:custom)
      subject
    end
  end

  describe "#(.*)_step! magic method" do
    subject { process.custom_step! }

    let(:step) { double("Fabrika::Step", run: true) }

    it "calls #run on the specified step" do
      process.steps.stub(:"[]").with(:custom) { step }
      step.should_receive(:run)
      subject
    end
  end

end