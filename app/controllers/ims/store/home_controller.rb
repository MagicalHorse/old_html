class Ims::Store::HomeController < Ims::Store::BaseController

  def index
  end

  def login
    @invite_code = params[:invite_code]   
    status = Ims::Store.create(request, {:invite_code => params[:invite_code]})
    if status[:isSuccessful]
      redirect_to my_ims_store_stores_path
    else
      render :action => :index
    end
  end

  def check_code
    
  end

end