module Fabrika
  class Step

    attr_accessor :process

    class << self

      def data(name, options = {}, &block)
        raise "Block Missing" unless block_given?
        define_method name do
          instance_eval(&block)
        end
      end

      def before(&block)
        add_callback :before, &block
      end

      def after(&block)
        add_callback :before, &block
      end


      def add_callback(event, &block)
        @callbacks ||= {}
        @callbacks[event] ||= []
        @callbacks[event] << block
      end

      def callbacks
        @callbacks || {}
      end

    end

    def initialize(process, options = {})
      @process, @options = process, options
    end

    def execute
      raise "#execute called on the Process base class. Please implement this method in the sub-class."
    end

    def run(*args)
      callbacks! :before
      execute_result = execute(*args)
      callbacks! :after
      execute_result
    end

    protected

    def callbacks!(event)
      return if self.class.callbacks.empty?

      self.class.callbacks[event].each do |callback|
        instance_eval &callback
      end
    end

  end
end