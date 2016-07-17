module Invisibill
  class Entity < Model
    def resource_name
      'entities'
    end
  end
  
  def save
    super
  end
end
