require_relative '04_associatable'

module Associatable

  def has_one_through(name, through_name, source_name)
    # self.assoc_options[name] = HasManyOptions.new(name, self.name, options)
    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]

      through_table = through_options.table_name
      through_pkey = through_options.primary_key
      through_fkey = through_options.foreign_key

      source_table = source_options.table_name
      source_pkey = source_options.primary_key
      source_fkey = source_options.foreign_key


      key_val = self.send(through_fkey)
      results = DBConnection.execute(<<-SQL, key_val)
      SELECT
        #{source_table}.*
      FROM
        #{through_table}
      JOIN
        #{source_table}
      ON
        #{source_table}.#{source_pkey} = #{through_table}.#{source_fkey}
      WHERE
        #{through_table}.#{through_pkey} = ?
      SQL


      source_options.model_class.parse_all(results).first
    end
  end
end
