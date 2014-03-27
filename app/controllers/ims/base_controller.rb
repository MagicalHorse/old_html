# encoding: utf-8
class Ims::BaseController < ApplicationController
  layout 'ims'
  before_filter :wx_auth!
  helper_method :current_user

  rescue_from Ims::Unauthorized do
    redirect_to(URI::HTTPS.build([nil, "open.weixin.qq.com", nil, "/connect/oauth2/authorize", {appid: Settings.wx.appid, redirect_uri: URI.escape("http://#{Settings.wx.backdomain}/ims/auth"), response_type: 'code', scope: 'snsapi_base', state: "STATE"}.to_param, 'wechat_redirect']).to_s)
    session[:back_url] = request.url
  end

  def backurl
    session[:back_url]||ims_cards_path
  end

  def current_user_id
    session[:inner_user_id]
  end

  def current_user
    @current_wx_user ||= session[:current_wx_user]
  end

  def wx_auth!
    get_token_from_api(request) unless session[:user_token]
  end

  private

  def get_token_from_api(request)
    user_hash = API::LoginRequest.post(request, {
      :outsiteuid       => Settings.wx.open_id,
      :outsitetype      => 4,
      :outsitetoken     => Ims::Weixin.access_token
    })
    session[:user_token] = user_hash[:data][:token]
    user = Ims::User.new({
      :id => user_hash[:data][:id],
      :email => user_hash[:data][:email],
      :level => user_hash[:data][:level],
      :nickname => user_hash[:data][:nickname],
      :mobile => user_hash[:data][:mobile],
      :isbindcard => user_hash[:data][:isbindcard],
      :logo => user_hash[:data][:logo],
      :level => user_hash[:data][:level],
      :operate_right => user_hash[:data][:operate_right],
      :token => user_hash[:data][:token],
      :verified_phone => "",
      :card_no => ""
      })

    session[:current_wx_user] = user
  end

  # 生成验证短信验证码
  def generate_sms
    session[:sms_code] = (0..9).to_a.sample(6)
    session[:sms_code] = 111111
  end

  # 验证短信内容，创建一次访问许可
  def validate_sms!
    if session[:sms_code].to_i != params[:sms_code].to_i
      redirect_to mine_ims_accounts_path
      p "验证失败，跳出"
    end
  end

end