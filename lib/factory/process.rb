class Fabrika::Process

  attr_accessor :steps

  class << self

    def steps(&block)
      @step_definition = block
    end

    def step_definition
      @step_definition
    end

  end

  def initialize
    initialize_steps
  end

  def add_step(name, options = {})
    klass_name = options.delete(:class_name) || "#{self.class}::Steps::#{name.to_s.camelcase}"
    steps[name] = klass_name.constantize.new(self, options)
  end

  alias :step :add_step

  protected

  def initialize_steps
    @steps = {}
    instance_eval &self.class.step_definition
  end

  def method_missing(name, *args)
    case name.to_s
      when /^(.*)_step$/
        steps[$1.to_sym]
      else
        super
    end
  end

end