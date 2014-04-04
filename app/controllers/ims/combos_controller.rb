class Ims::CombosController < Ims::BaseController
  layout "store"
  
  def show
    @remote_combo = Ims::Combo.show(request, {:id => params[:id]})
    @private_to = params[:private_to]
  end
end