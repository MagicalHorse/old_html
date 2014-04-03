class Ims::FavoritesController < Ims::BaseController

  def stores_list
    @stores = Ims::UserApi.favor_store(request, {page: (params[:page] || 1)} )["data"]["items"]
  end

  def combos_list
    @combos = Ims::UserApi.favor_combo(request, {page: (params[:page] || 1)} )["data"]["items"]
  end
  
  def create
    # API_NEED: 添加到列表
    # 添加收藏的ajax
    Ims::UserApi.favor(request, type: params[:type], id: params[:id])
  end
  
  def destroy
    # API_NEED: 删除收藏
    # 删除收藏的ajax
    Ims::UserApi.unfavor(request, type: params[:type], id: params[:id])
  end
end