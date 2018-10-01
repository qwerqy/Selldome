class UsersController < Clearance::UsersController

  def new
    @user = User.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @user = User.find(params[:id])
    render 'users/profile'
  end

  def edit
    if current_user
      @user = User.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Succesfully Updated"
      redirect_to profile_path
    else
      flash[:danger] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  def upload_photo
    @user = User.find(params[:id])
    render 'users/upload-profile-photo'
    respond_to do |format|
      format.js
    end
  end

  def remove_photo
    @user = User.find(params[:id])
    @user.remove_avatar!
    if @user.save
      flash[:warning] = "Profile Photo has been removed."
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Error Occured, please try again later."
      redirect_back(fallback_location: root_path)
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
    superadmin = user_params.delete(:superadmin)
    moderator = user_params.delete(:moderator)
    customer = user_params.delete(:customer)

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
      user.superadmin = superadmin
      user.moderator = moderator
      user.customer = customer
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
          :avatar,
          :about_me,
          :password,
          :remote_avatar_url,
          :superadmin,
          :moderator,
          :customer,
          :review_ids => [],
          :listing_ids => []
        )
  end
end
