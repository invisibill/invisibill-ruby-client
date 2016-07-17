module Invisibill
  class Resource < Model
    def resource_name
      'resources'
    end
  end
  
  def save
    super
  end
end
