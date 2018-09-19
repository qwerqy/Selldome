class UsersController < Clearance::UsersController

  # def user_from_params
  #   user_params = params[:user] || Hash.new
  # end

  def new
    @user = User.new
    # render template: "users/new"
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @user = User.find(params[:id])
    render template: 'users/profile'
  end

  def edit
    if current_user
      @user = User.find(params[:id])
      render template: 'users/edit'
    else
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def upload_photo
    @user = User.find(params[:id])
    render template: 'users/upload-profile-photo'
    respond_to do |format|
      format.js
    end
  end

  private

  def user_from_params
    first_name = user_params.delete(:first_name)
    last_name = user_params.delete(:last_name)
    country = user_params.delete(:country)
    gender = user_params.delete(:gender)
    birthday = user_params.delete(:birhday)
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    avatar = user_params.delete(:avatar)
    about_me = user_params.delete(:about_me)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.first_name = first_name
      user.last_name = last_name
      user.country = country
      user.gender = country
      user.birthday = birthday
      user.email = email
      user.password = password
      user.avatar = avatar
      user.about_me = about_me
    end
  end

  def user_params
    params.require(:user)
        .permit(
          :first_name,
          :last_name,
          :country,
          :gender,
          :birthday,
          :email,
          :phone,
          :password,
          :avatar,
          :about_me,
          :remote_avatar_url
        )
  end
end
