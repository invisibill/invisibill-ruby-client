module Invisibill
  class Token < Model
    def resource_name
      'tokens'
    end
  end

  def save
    super
  end
end
