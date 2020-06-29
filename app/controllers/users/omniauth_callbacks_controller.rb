class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  


  def new 
    @user = User.new
  end


  def index
    @users = User.all
  end
  
  def google_oauth2
        # You need to implement the method below in your model (e.g. app/models/user.rb)
        @user = User.from_omniauth(request.env['omniauth.auth'])
  
        if @user.persisted?
          flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
          sign_in_and_redirect @user, event: :authentication
        else
          session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
          redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
        end
    end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
     unless user
        user = User.create(name: data['name'],
            email: data['email'],
            password: Devise.friendly_token[0,20]
         )
     end
    user
end



private 

def user_params
  params.require(:user).permit(:username, :email, :password, :salt, :encrypted_password)
end


def role_admin
  unless current_user.admin?
      format.html { redirect_to schedule_path, notice: 'Please check your access. Admin only area' } 
  end  
end 

end