class Nesting
  def give_me_nested()
    InsideClass.new
  end
  class InsideClass

  end
  class NestedClass

  end
end