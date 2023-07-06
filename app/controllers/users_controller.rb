class UsersController < ApplicationController
    before_action :already_logged_in, only: %i(new create)
    skip_before_action :login_required, only: %i(new create)
    before_action :set_user, only: %i(show edit update)
    before_action :is_current_user, only: %i(show edit update)
  
    def show
      current_user_required(@user)
    end
  
    def new
      @user = User.new
    end
  
    def edit
    end
  
    def create
      @user = User.new(user_params)
  
      if @user.save
        log_in(@user)
        redirect_to tasks_path, notice: 'Votre compte est créé avec succès'
      else
        render :new
      end
    end
  
    def update
      if @user.update(user_params)
        redirect_to @user, notice: 'Votre compte a été mise à jour avec succès'
      else
        render :edit
      end
    end
  
    private
      def set_user
        @user = User.find(params[:id])
      end
  
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
      def is_current_user
        current_user_required(@user)
      end
end
