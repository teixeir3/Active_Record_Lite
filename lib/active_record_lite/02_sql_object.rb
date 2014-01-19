require_relative 'db_connection'
require_relative '01_mass_object'
require 'active_support/inflector'

class MassObject
  def self.parse_all(results)
   results.map { |result| self.new(result) }
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
    # fetches all the records from the database
    results = DBConnection.execute(<<-SQL)
    SELECT
      #{self.table_name}.*
    FROM
      #{self.table_name}
    SQL

    self.parse_all(results)
  end

  def self.find(id)
    # returns a single object where primarykey = id
    results = DBConnection.execute(<<-SQL, id)
    SELECT
      #{self.table_name}.*
    FROM
      #{self.table_name}
    WHERE
      #{self.table_name}.id = ?
    SQL

    self.parse_all(results).first
  end

  def insert
    col_names = self.class.attributes.join(", ")
    question_marks = (["?"] * self.class.attributes.length).join(", ")

    DBConnection.execute(<<-SQL, *attribute_values)
        INSERT INTO
          #{self.class.table_name} (#{col_names})
        VALUES
          (#{question_marks})
        SQL
    self.id = DBConnection.last_insert_row_id
  end

  def save
    # if id is nil, it's not in DB => insert, otherwise update
    id ? self.update : self.insert
  end

  def update
    # updates a record's attributes:
    set_line = self.class.attributes.map{ | attr_name| "#{attr_name} = ?" }.join(", ")

    DBConnection.execute(<<-SQL, *attribute_values, self.id)
        UPDATE
          #{self.class.table_name}
        SET
          #{set_line}
        WHERE
          #{self.class.table_name}.id = ?
        SQL
  end

  def attribute_values
    # returns array of values for each attribute
    self.class.attributes.map { |attribute| self.send(attribute) }
  end
end
