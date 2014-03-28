class Ims::ProductCoding < Ims::Base

 class << self
   def list(req, params={})
     post(req, params.merge(path: 'ims/assistant/salescodes'))
   end

   def create(req, params={})
     post(req, params.merge(path: 'ims/assistant/salescode_add'))
   end
 end

end