class FollowsController < ApplicationController
  before_action :authenticate_user!

  def follow_user
    follow_found = Follow.where(user_id: current_user.id, followable_type: "User", followable_id: params[:id]).any?
    if follow_found
      flash[:notice] = 'User already followed'
      redirect_to questions_path
    else
      follow = Follow.new(user_id: current_user.id)
      user = User.find_by(id: params[:id])
      follow.followable = user
      follow.save
      redirect_to root_path
    end
  end

  def follow_topic
    follow_found = Follow.where(user_id: current_user.id, followable_type: "Topic", followable_id: params[:id]).any?
    if follow_found
      flash[:notice] = 'Topic already followed'
      redirect_to questions_path
    else
      follow = Follow.new(user_id: current_user.id)
      topic = Topic.find_by(id: params[:id])
      follow.followable = topic
      follow.save
      flash[:notice] = 'Topic followed'
      redirect_to root_path
    end
  end

end
