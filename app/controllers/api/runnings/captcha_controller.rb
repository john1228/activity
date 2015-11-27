module Api
  module Runnings
    class CaptchaController < ApplicationController
      protect_from_forgery

      def create
        captcha = generate_captcha
        SmsJob.perform_now(params[:mobile], SMS['验证码'], ["#{captcha}", '30'])
        Rails.cache.write(params[:mobile], captcha)
        render json: {code: 1}
      end

      private
      def generate_captcha
        %w'0 1 2 3 4 5 6 7 8 9'.sample(6)
      end
    end
  end
end
