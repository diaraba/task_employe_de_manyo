class Admin::UsersController < ApplicationController
   
    before_action :set_user, only: %i(show edit update destroy)
    before_action :admin_required

    def new
        @user=User.new
        
    end

    def index
        @users = User.includes(:tasks).all
    end

    def create
        @user = User.new(user_params)
        if @user.save
        redirect_to admin_users_path , notice: "Utilisateur enregistré"
        else
        render :new
        end
    end

    def show
        tasks =@user.tasks

        if params[:sort_deadline_on]
            tasks = tasks.sort_deadline_on.sort_created_at
        elsif params[:sort_priority]
            tasks = tasks.sort_priority.sort_created_at
        else
            tasks = tasks.sort_created_at
        end
        @tasks = tasks.page(params[:page]).per(10)
    end

    def edit
        @user = User.find(params[:id])

  
    end


    def update
    
        

        @user = User.find(params[:id])
       
       
        if @user.update(user_params)
            redirect_to admin_users_path, notice: "	Utilisateur mis à jour"
        else
            render :edit
        end
    end

    def destroy
        @user = User.find(params[:id])
        if @user.destroy
         redirect_to admin_users_path, notice: "Utilisateur supprimé"
        else
         redirect_to admin_users_path, notice: "Impossible de supprimer car il n'y a que 1 administrateurs"
        end  
    end
      


    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end

    def correct_user
        @user=User.find(params[:id])
        redirect_to current_user unless current_user?(@user)
    end   
end