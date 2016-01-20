class WebchatController < ApplicationController
  def key
    nonce_str = %w'a b c d e f g h i j k l m n o p q r s t w v u x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9'.sample(16).join
    timestamp = Time.now.to_i.to_s
    sign_key = sign('htto://www.e-mxing.com', nonce_str, timestamp)
    render json: {
               appid: 'wx6709047495527262',
               timestamp: timestamp,
               nonce_str: nonce_str,
               key: sign_key
           }
  end

  private
  def sign(url, nonce_str, timestamp)
    api_ticket = Rails.cache.fetch('api_ticket')
    api_ticket = get_js_api_ticket if api_ticket.blank?
    url_str = "jsapi_ticket=" + api_ticket + "&noncestr=" + nonce_str + "&timestamp=" + timestamp + "&url=" + url
    Digest::SHA1.hexdigest(url_str)
  end

  def get_js_api_ticket
    appid = 'wx6709047495527262'
    secret = 'a454f2ad091c23d3210241a7e875c0d4'
    conn = Faraday.new(url: "https://api.weixin.qq.com/")
    access_token_response = conn.get 'cgi-bin/token', grant_type: 'client_credential', appid: appid, secret: secret
    access_token = JSON.parse(access_token_response.body)['access_token']
    api_ticket_response = conn.get 'cgi-bin/ticket/getticket', type: 'jsapi', access_token: access_token
    api_ticket = JSON.parse(api_ticket_response.body)['ticket']
    Rails.cache.write('api_ticket', api_ticket, expires_in: 7200)
  end
end
