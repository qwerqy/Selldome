class UsersController < Clearance::UsersController

  private

  def user_params
    params.permit(
      :first_name,
      :last_name,
      :birthday,
      :email,
      :phone,
      :password
    )
  end
end
