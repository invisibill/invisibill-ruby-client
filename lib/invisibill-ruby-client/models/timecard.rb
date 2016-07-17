module Invisibill
  class Timecard < Model
    def resource_name
      'timecards'
    end
  end
  
  def save
    super
  end
end
