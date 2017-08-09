require "transform_combinators/version"
require 'fp_rb'

module TransformCombinators
  def_fn :same, :hash_of, :array_of, :default, :scalar, :float, :integer, :null_string, :and_then

  @@same = ->a { a }
  @@hash_of = ->fields, hash {
    hash ||= {}
    fields.map { |(key, fn)| [key, fn.(hash[key])] }.to_h
  }.curry
  @@array_of = ->fn, value { value.is_a?(Array) ? value.map(&fn) : [] }.curry
  @@default = ->default, a { a.nil? ? default : a }.curry
  @@scalar = ->a { a.is_a?(Array) || a.is_a?(Hash) ? nil : a }
  @@integer = ->a { Integer(a) }
  @@float = ->a { Float(a) }
  @@null_string = ->a {
    unless a.nil?
      b = a.strip
      b.empty? ? nil : a
    end
  }
  @@and_then = ->fn, a { a.nil? ? nil : fn.(a) }.curry
end
