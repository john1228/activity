module Api
  module Runnings
    class CommentsController < ApplicationController
      protect_from_forgery
      before_filter :auth_user, except: [:index, :like]

      def index
        running = Running.find_by(phase: params[:phase])
        if running.present?
          render json: {
                     code: 1,
                     data: Comment.running.where(source_id: running.id).order(id: :desc).page(params[:page]||1).map { |comment|
                       comment.as_json(
                           only: [:id, :content, :likes_count],
                           include: {
                               user: {only: [:id, :name]},
                               replier: {only: [:id, :name]}
                           }
                       )
                     }
                 }
        else
          render json: {code: 0, message: '您查看的期数不存在'}
        end

      end

      def create
        running = Running.find_by(phase: params[:phase])
        comment = Comment.running.new(comment_params.merge(source_id: running.id))
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
        params.permit(:reply_id, :content)
      end

      def auth_user
        @user = Rails.cache.fetch(request.headers[:token])
      end
    end
  end
end
