require_relative 'db_connection'
require_relative '01_mass_object'
require 'active_support/inflector'

class MassObject
  def self.parse_all(results)
    # To turn each of the Hashes into Humans, write a SQLObject::parse_all method.
    # Iterate through the results, using new to create a new instance for each.

    # new what? SQLObject.new? That's not right, we want Human.all to return Human objects, and Cat.all to return Cat objects. Hint: inside the ::parse_all class method,
    # self = MassObject class
  end
end

class SQLObject < MassObject
  def self.table_name=(table_name)
    # getter method which gets name of table for the class
    # use class ivar to store this
    @table_name = table_name
  end

  def self.table_name
    # getter method which gets name of table for the class
    # use class ivar to store this
    default_table_name = "#{self}".pluralize.underscore
    @table_name ||= default_table_name
  end

  def self.all
    #### START HERE #####################################

    # fetches all the records from the database

    # 1st: tru to generate neccesarry SQL query using Heredoc to do this
    DBConnection.execute(<<-SQL)
    SELECT
      #{self.table}

    SQL
  end

  def self.find(id)
    # returns a single object where primarykey = id
    # don't use ::all.
    # write SQL query to find only 1 object
  end

  def insert
    # Executes query
    # INSERT INTO table_name (col1, col2, col3) VALUES (?, ?, ?)

    # uses 2 local vars:
    # col_names: array of ::attributes joined with commas
    # question_marks: array of ? (ex: ["?"] x 3) joined with commas

    # call DBConnection.execute
    # pass values of columns
  end

  def save
    # calls #insert if id.nil? (it's not in the db already)
    # otherwise call #update
  end

  def update
    # updates a record's attributes:
    # Query like: UPDATE table_name SET col1 = ?, col3 = ?, col3 = ? WHERE id = ?
  end

  def attribute_values
    # returns array of values for each attribute
    # by calling Array#map on SQLObject::attributes, calling send on the instance to get the value.
    # SQLObject::attributes.map(:send) < something like this. unfinished.
  end
end
