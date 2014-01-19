require_relative '03_searchable'
require 'active_support/inflector'

class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key,
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    defaults = {
      :foreign_key => "#{name}_id".to_sym,
      :class_name => name.to_s.camelcase,
      :primary_key => :id
    }

    defaults.keys.each do |k|
      self.send("#{k}=", options[k] || defaults[k])
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    defaults = {
      :foreign_key => "#{self_class_name.underscore}_id".to_sym,
      :class_name => name.to_s.singularize.camelcase,
      :primary_key => :id
    }

    defaults.keys.each do |k|
      self.send("#{k}=", options[k] || defaults[k])
    end
  end
end

module Associatable
  def belongs_to(name, options = {})
    self.assoc_options[name] = BelongsToOptions.new(name, options)

    define_method(name) do
      bt_options = self.accoc_options[name]
      key_val = self.send(bt_options.foreign_key)
      bt_options.model_class.where(bt_options.primary_key => key_val).first
    end
  end

  def has_many(name, options = {})
    self.assoc_options[name] = HasManyOptions.new(name, self.name, options)

    define_method(name) do
      hm_options = self.assoc_options[name]
      key_val = self.send(hm_options.primary_key)
      hm_options.model_class.where(hm_options.foreign_key => key_val)
    end

  end

  def assoc_options
    @assoc_options||= {}
    @assoc_options
  end
end

class SQLObject
  extend Associatable
end
