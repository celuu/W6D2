require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns
    col = DBConnection.execute2("
      SELECT
        *
      FROM
       #{table_name}
    ")
    @columns = col.first.map {|c| c.to_sym}
  end

  def self.finalize!
    columns.each do |col|
      define_method("#{col}=".to_sym) do |new_value|
        attributes[col] = new_value
      end
      define_method("#{col}".to_sym) do
        attributes[col] 
       end  
    end
  end

  def self.table_name=(table_name)
  end

  def self.table_name
    @table_name = self.to_s.downcase + 's'
    
    # ...
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    params.each do |p, v|
      sym = p.to_sym
      if !self.class.columns.include?(sym)
        raise "unknown attribute '#{p}'"
      else
        send("#{sym}=",v) 
      end 
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
