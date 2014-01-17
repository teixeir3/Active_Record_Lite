require_relative '00_attr_accessor_object.rb'

class MassObject < AttrAccessorObject


  def self.my_attr_accessible(*new_attributes)
    # Performs mass-assignment
    # current_attributes = self.attributes
#     current_attributes.concat(new_attributes)
    @attributes = self.attributes.concat(new_attributes)
  end

  def self.attributes
    # ...
    # should start off empty
    # should return an array of all attributs you've whitelisted
    if self == MassObject
      raise "must not call #attributes on MassObject directly"
    end
    @attributes ||= []



  end

  def initialize(params = {})
    # params = {:x => "xxx", :y => "yyy"}
    # p params
    # p self.class.attributes
    unless params.empty?
      params.each do | attr_name, value |
        unless attr_name.is_a?(Symbol)
          attr_name = attr_name.to_sym
        end
        unless self.class.attributes.include?(attr_name)
          raise "mass assignment to unregistered attribute '#{attr_name}'"
        end
        self.send("#{attr_name}=", value)
      end
    end

  end
end
