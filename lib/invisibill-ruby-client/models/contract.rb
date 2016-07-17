module Invisibill
  class Contract < Model
    def resource_name
      'contracts'
    end
  end
  
  def save
    super
  end
end
