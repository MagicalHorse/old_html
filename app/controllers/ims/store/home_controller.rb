class Ims::Store::HomeController < Ims::Store::BaseController
  skip_filter :authenticate
  before_filter :go_store
  

  def index
  end

  def login
    @invite_code = params[:invite_code]
    @status = Ims::Store.create(request, {:invite_code => params[:invite_code]})
    if @status[:isSuccessful]
      user = Ims::User.new({
      :id => status[:data][:id],
      :email => status[:data][:email],
      :level => status[:data][:level],
      :nickname => status[:data][:nickname],
      :mobile => status[:data][:mobile],
      :isbindcard => status[:data][:isbindcard],
      :logo => status[:data][:logo],
      :operate_right => status[:data][:operate_right],
      :token => status[:data][:token],
      :store_id => status[:data][:associate_id],
      :max_comboitems => status[:data][:max_comboitems]
      })
      session[:current_wx_user] = user
      redirect_to my_ims_store_store_path(:id => user.store_id)
    else
      @error = true
      render :action => :index
    end
  end

  def check_code

  end


  private
  def go_store
    if current_user.store_id.present?
      redirect_to my_ims_store_store_path(:id => current_user.store_id)
    end
  end

end
