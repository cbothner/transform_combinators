require "transform_combinators/version"

class Module
  def def_fnc(*syms)
    syms.each do |sym|
      raise NameError.new("invalid function name: #{sym}") unless /\A[_A-Za-z]\w*\z/ =~ sym
      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        def #{sym}
            @@#{sym}
        end
      EOS
    end
  end
end

module TransformCombinators
  def_fnc :same, :hash_of, :array_of, :default, :scalar

  @@same = -> a { a }
  @@hash_of = -> fields , hash { 
    hash ||= {}
    fields.map { |(key, fn)| [key, fn.(hash[key])] }.to_h
  }.curry
  @@array_of = -> fn, value { value.kind_of?(Array) ?  value.map(&fn) : [] }.curry
  @@default = -> default, a { a.nil? ? default : a  }.curry
  @@scalar = -> a { a.kind_of?(Array) || a.kind_of?(Hash) ? nil : a }
end
