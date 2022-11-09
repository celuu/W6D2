class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      define_method("#{name}=".to_sym) do |new_value|
        instance_variable_set("@#{name}", new_value)
      end
      define_method(name) do
        instance_variable_get("@#{name}".to_sym)
      end
    end
  end
end
