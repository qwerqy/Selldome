class SessionsController < Clearance::SessionsController
  def create_from_omniauth
    auth_hash = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) ||  Authentication.create_with_omniauth(auth_hash)

    # if: previously already logged in with OAuth
    if authentication.user
      user = authentication.user
      authentication.update_token(auth_hash)
      @next = root_url
      @notice = "Signed in!"
    # else: user logs in with OAuth for the first time
    else
      user = User.create_with_auth_and_hash(authentication, auth_hash)
      # you are expected to have a path that leads to a page for editing user details
      @next = user_edit_path(user)
      @notice = "User created. Please confirm or edit details"
    end

    sign_in(user)
    redirect_to @next, :notice => @notice
  end

  def new
   # render template: "sessions/new"
   respond_to do |format|
     format.html
     format.js
   end
  end

  def create
    @user = authenticate(params)

    sign_in(@user) do |status|
      if @user.superadmin?
        if status.success?
          redirect_back_or admin_panel_path
        else
          flash.now.notice = status.failure_message
          render template: "sessions/new", status: :unauthorized
        end
      elsif @user.moderator?
        if status.success?
          redirect_back_or moderator_panel_path
        else
          flash.now.notice = status.failure_message
          render template: "sessions/new", status: :unauthorized
        end
      elsif @user.customer?
        if status.success?
          redirect_back_or url_after_create
        else
          flash.now.notice = status.failure_message
          render template: "sessions/new", status: :unauthorized
        end
      end
    end
  end

  def url_after_destroy
    root_url
  end

end
