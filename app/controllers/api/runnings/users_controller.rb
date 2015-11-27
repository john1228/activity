module Api
  module Runnings
    class UsersController < ApplicationController
      protect_from_forgery

      def create
        captcha = Rails.cache.fetch(params[:mobile])
        if true #captcha.eql?(params[:captcha])
          user = User.running.new(user_params)
          if user.save
            render json: {code: 1}
          else
            render json: {code: 0, message: '注册失败'}
          end
        else
          render json: {code: 0, message: '无效的验证码'}
        end
      end


      def login
        user = User.login(login_params)
        if user.present?
          Rails.cache.fetch(user.token, user)
          render json: {code: 1, data: user.as_json(only: :name, methods: :token)}
        else
        end
      end

      private
      def user_params
        params.permit(:mobile, :password, :name)
      end

      def login_params
        params.permit(:mobile, :password)
      end
    end
  end
end
