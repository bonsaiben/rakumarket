# DSL for defining data extraction rules from an abstract document object
module SpitterMethods
  def self.extended(base)
    base.send(:include, InstanceMethods) if base.is_a? Class
  end

  # Declare a singular spitting rule
  def parameter(*args, &block)
    key, name, delegate = parse_rule_declaration(*args, &block)
    rules[key] = [name, delegate]
    key
  end

  # Declare a plural spitting rule
  def parameters(*args, &block)
    key = parameter(*args, &block)
    rules[key] << true
  end

  # Parsing rules declared with `parameter` or `parameters`
  def rules
    @rules ||= {}
  end

  # Process data by creating a new instance
  def parse(params) new(params).parse end

  private

  # Make subclasses inherit the parsing rules
  def inherited(subclass)
    super
    subclass.rules.update self.rules
  end

  # Rule declaration forms:
  #
  #   { :key => 'property', :with => delegate }
  #     #=> [:key, 'property', delegate]
  #
  #   :title
  #     #=> [:title, 'title', nil]
  def parse_rule_declaration(*args, &block)
    options, name = Hash === args.last ? args.pop : {}, args.first
    delegate = options.delete(:with)
    key, property = name ? [name.to_sym, name.to_s] : options.to_a.flatten
    property = property[key.to_s] if property.is_a?(Proc)
    property = property.method(property.respond_to?(:call) ? :call : :parse)[key.to_s] if property.is_a?(Class)
    raise ArgumentError, "invalid rule declaration: #{args.inspect}" unless property
    # eval block in context of a new scraper subclass
    delegate = Class.new(Spitter, &block) if block_given?
    return key, property, delegate
  end

  def base_parser_class
    klass = self
    klass = klass.superclass until klass.superclass == Object
    klass
  end

  module InstanceMethods

    # Initialize the parser with a parameters
    def initialize(params)
      @params = params
    end

    def params
      @params ||= {}
    end

    def parse
      request_params = {}
      self.class.rules.each do |target, (key, delegate, plural)|
        if @params.has_key?(target)
          if plural
            request_params.merge!(delegate.parse(@params[target]))
          else
            request_params[key] = parse_result(@params[target], delegate)
          end
        end
      end
      request_params
    end

    protected

    # `delegate` is optional, but should respond to `call` or `parse`
    def parse_result(node, delegate)
      if delegate
        method = delegate.is_a?(Proc) ? delegate : delegate.method(delegate.respond_to?(:call) ? :call : :parse)
        method.arity == 1 ? method[node] : (method.arity == 2 ? method[node, self] : method[])
      else
        node
      end
    end
  end
end

class Spitter
  extend SpitterMethods
end
