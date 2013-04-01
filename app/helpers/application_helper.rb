module ApplicationHelper
  def small_pic_url(r)
    domain = PIC_DOMAIN 
    return domain + r[:name] +'_120x0.jpg'
  end
  def large_pic_url(r)
    domain = PIC_DOMAIN
    return domain + r[:name] +'_640x0.jpg'
  end
end
