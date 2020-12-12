class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = []
    User.all.each do |user|
      @users << user if user != current_user
    end
    @friends = current_user.friends
    @pending_requests = current_user.pending_requests
    @friend_requests = current_user.received_requests
  end

  def show
    @user = User.find(params[:id])
    #@posts = @user.posts.ordered_by_most_recent
    @posts = current_user.friends_and_own_posts
  end
end
