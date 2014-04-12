class Ims::Store::IncomesController < Ims::Store::BaseController

  def index

  end

  def my
    @income = Ims::Income.my(request)
    @title = "我的收益"
  end

  def new
    @banks = Ims::Income.banks(request)
    @income = Ims::Income.my(request)
    @title = "申请提现"
  end

  def create
    @income = Ims::Income.apply(request, {bank_code: params[:bank_code], bank_no: params[:bank_no], amount: params[:amount], user_name: params[:user_name]})
  end

  def list
    @list = Ims::Income.list(request)
    @title = "已提现列表"
  end

  def frozen
    @list = Ims::Income.frozen(request)
    @title = "不可提现列表"
  end

  def tips
    
  end


end
