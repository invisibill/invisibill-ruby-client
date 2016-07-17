module Invisibill
  class Invoice < Model
    def resource_name
      'invoices'
    end
  end
  
  def save
    super
  end
end
