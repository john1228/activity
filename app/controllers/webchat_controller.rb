class WebchatController < ApplicationController
  def key
    @appid = 'wxe08328a54d86afd8'
    @nonce_str = SecureRandom.uuid
    @timestamp = Time.now.to_i.to_s
    logger.info request.url
    @signature = sign(request.url, @nonce_str, @timestamp)
    render layout: false
  end

  private
  def sign(url, nonce_str, timestamp)
    wx_api_ticket = Rails.cache.fetch('wx_api_ticket')
    wx_api_ticket = get_js_api_ticket if wx_api_ticket.blank?

    signature_string = "jsapi_ticket=" + wx_api_ticket + "&noncestr=" + nonce_str + "&timestamp=" + timestamp + "&url=" + url
    Digest::SHA1.hexdigest(signature_string)
  end

  def get_js_api_ticket
    wx_access_token = Rails.cache.fetch('wx_access_token')
    conn = Faraday.new(url: "https://api.weixin.qq.com/")
    if wx_access_token.blank?
      appid = 'wxe08328a54d86afd8'
      secret = '8e49133310752495e4af9eac5942f5ed'
      access_token_response = conn.get 'cgi-bin/token', grant_type: 'client_credential', appid: appid, secret: secret
      access_token = JSON.parse(access_token_response.body)['access_token']
      Rails.cache.write('wx_access_token', access_token, expires_in: 7200)
    end
    api_ticket_response = conn.get 'cgi-bin/ticket/getticket', type: 'jsapi', access_token: wx_access_token
    api_ticket = JSON.parse(api_ticket_response.body)['ticket']
    Rails.cache.write('wx_api_ticket', api_ticket, expires_in: 7200)
    api_ticket
  end
end
