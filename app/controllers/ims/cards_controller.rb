class Ims::CardsController < Ims::BaseController

  # 充值历史
  def index
    
  end

  # 给自己充值
  def recharge
    unless current_user.isbindcard
      # 如果未绑定，则跳至绑卡页面
      current_user.will_chargeno = params[:charge_no]
      redirect_to new_ims_account_path
    end
    # API_NEED: 充值礼品卡接口
    @data = Ims::Giftcard.recharge(request, charge_no: params[:charge_no])
    current_user.will_chargeno = nil
  end

  # 赠送给别人
  def present
    # API_NEED: 赠送礼品卡接口
    @result = Ims::Giftcard.send(request, charge_no: params[:charge_no])

    # 1、入参：卡号、当前用户id、赠与的用户手机号
    # 2、返回：是否成功
  end

end