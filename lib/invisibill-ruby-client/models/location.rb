module Invisibill
  class Location < Model
    def resource_name
      'locations'
    end
  end
  
  def save
    super
  end
end
