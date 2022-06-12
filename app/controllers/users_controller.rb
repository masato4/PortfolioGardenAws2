class UsersController < ApplicationController


  # def new
  #   render template: "skills/new"
  # end

  def index
    @users = User.where.not(id: current_user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @skill = Skill.new
    @skills=Skill.all.order("id")
    @user=User.find(params[:id])
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  def likes
    @skill = Skill.new
    @skills=Skill.all.order(created_at: :asc)
    @user = User.find(params[:id])
    likes = Like.where(user_id: @user.id).pluck(:tweet_id)
    @like_tweets = Tweet.find(likes)
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :profile, :image)
    end

    def set_user
      @user = User.find([:id])
    end



  # def user_params
    # params.fetch(:user, {}).permit(:username)
  # end

end
