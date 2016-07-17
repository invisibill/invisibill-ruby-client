module Invisibill
  class Model < HashWithIndifferentAccess
    class << self
      def find(id)
        model = self.new
        uri = model.uri
        req = uri.split(/\//i).size == 1 ? model.api_client.get("#{uri}/#{id}") : model.api_client.get(uri, id: id)
        response = JSON.parse(req.response_body) rescue nil
        response = response[0] if response.is_a?(Array) && response.size == 1
        model.merge!(response) if req.code == 200
        model
      end
      
      def where(params)
        model = self.new
        models = []
        req = model.api_client.get("#{model.uri}", params)
        response = JSON.parse(req.body) rescue nil
        response.each do |item|
          m = self.new
          m.merge!(item)
          models << m
        end if req.code == 200 && response.is_a?(Array)
        models
      end
    end

    def api_client
      @api_client ||= begin
        ApiClient.new(INVISIBILL_API_TOKEN)
      end
    end

    def delete
      return unless self[:id]
      api_client.delete("#{uri}/#{self[:id]}")
    end

    def resource_name
      nil
    end

    def save
      if self[:id]
        req = api_client.put("#{uri}/#{self[:id]}", self)
      else
        req = api_client.post(uri, self)
        merge!(JSON.parse(req.response_body)) if req.code == 201
      end
      req
    end

    def uri
      "#{resource_name.to_s}"
    end
  end
end
