module API
  module LoginRequest
    extend API::Restful

    def self.post(req, params = {})
      super(req, params.merge(path: 'customer/outsitelogin'))
    end
  end
end