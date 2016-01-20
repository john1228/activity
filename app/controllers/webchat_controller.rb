class WebchatController < ApplicationController
  def key
    nonce_str = %w'a b c d e f g h i j k l m n o p q r s t w v u x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9'.sample(16).join
    timestamp = Time.now.to_i.to_s
    sign_key = sign('htto://e-mxing.com', nonce_str, timestamp)
    render json: {
               appid: 'wx6709047495527262',
               timestamp: timestamp,
               nonce_str: nonce_str,
               key: sign_key
           }
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
      Rails.cache.write('wx_access_token', access_token)
    end
    api_ticket_response = conn.get 'cgi-bin/ticket/getticket', type: 'jsapi', access_token: wx_access_token
    api_ticket = JSON.parse(api_ticket_response.body)['ticket']
    Rails.cache.write('wx_api_ticket', api_ticket, expires_in: 7200)
  end
end
