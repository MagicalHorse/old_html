module Front::PromotionsHelper
  
  def display_store_map(store)
    "<img src=http://api.map.baidu.com/staticimage?center=#{store.lng},#{store.lat}&markers=#{store.lng},#{store.lat}&amp;width=560&amp;height=400&amp;zoom=13&amp;&markerStyles=-1,http://api.map.baidu.com/images/marker_red.png,-1>"   
  end
end
