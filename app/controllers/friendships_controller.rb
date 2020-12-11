class FriendshipsController < ApplicationController
  include ApplicationHelper

  def create
    return if current_user.id == params[:user_id]
    return if friend_request_sent?(User.find(params[:user_id]))
    return if friend_request_received?(User.find(params[:user_id]))

    @user = User.find(params[:user_id])
    @friendship = current_user.friend_sent.build(sent_to_id: params[:user_id])
    if @friendship.save
      redirect_to users_path, notice: 'friend request sent.'
    else
      flash[:danger] = 'Friend Request Failed!'
    end
  end

  def accept
    @friendship = Friendship.find_by(sent_by_id: params[:user_id], sent_to_id: current_user.id, status: false)
    return unless @friendship

    @friendship.status = true
    if @friendship.save
      @friendship2 = current_user.friend_sent.build(sent_to_id: params[:user_id], status: true)
      @friendship2.save
      redirect_to users_path, notice: 'Friend Request Accepted!'
    else
      flash[:danger] = 'Friend Request could not be accepted!'
    end
  end

  def decline
    @friendship = Friendship.find_by(sent_by_id: params[:user_id], sent_to_id: current_user.id, status: false)
    return unless @friendship

    @friendship.destroy
    redirect_to users_path, notice: 'Friend Request Denied!'
  end
end
