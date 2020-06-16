class UsersController < ApplicationController


    def index
        @users = User.all
      end

private 

def role_admin
    unless current_user.admin?
        format.html { redirect_to schedule_path, notice: 'Please check your access. Admin only area' } 
    end  
  end 
end