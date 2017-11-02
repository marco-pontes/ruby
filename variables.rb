class Variables
  def initialize(var1)
    @object_property = var1
    if defined?(@@class_property)
      @@class_property += 1
    else
      @@class_property = 1
    end
    $global_prop = 40
  end
#static method
  def self.count
    @@class_property
  end

  def Variables.count2
    @@class_property
  end

  def get_object_property()
    @object_property
  end
  def get_class_property()
    @@class_property
  end
end