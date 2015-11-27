module Api
  module Runnings
    class CommentsController < ApplicationController
      protect_from_forgery
      before_filter :auth_user, except: :index

      def index
        running = Running.find_by(phase: params[:phase])
        if running.present?
          render json: {
                     code: 1,
                     data: Comment.running.where(source_id: running.id).order(id: :desc).page(params[:page]||1).map { |comment|
                       comment.as_json(only: [:content, :likes_count], include: {user: {only: :name}})
                     }
                 }
        else
          render json: {code: 0, message: '您查看的期数不存在'}
        end

      end

      def create
        comment = Comment.running.new(comment_params)
        if comment.save
          render json: {code: 1}
        else
          render json: {code: 0}
        end
      end

      def like
        comment = Comment.find_by(id: params[:id])
        if comment.present?
          comment.update(likes_count: comment.likes_count + 1)
          render json: {code: 1}
        else
          render json: {code: 0, message: '您赞的评论不存在'}
        end
      end

      private
      def comment_params
        params.permit(:content)
      end

      def auth_user
        Rails.cache.fetch(request.headers[:token])
      end
    end
  end
end
