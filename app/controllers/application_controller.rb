class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper

    before_action :login_required
  
    private
        def login_required
        redirect_to new_session_path, notice: "Veuillez vous connecter" unless current_user
        end

        def already_logged_in
        redirect_to tasks_path, notice: "veuillez vous déconnecter" if current_user
        end

        def admin_required
        redirect_to tasks_path, notice: "Seuls les administrateurs peuvent accéder" unless current_user.admin
        end
        
        def current_user_required(user)
        redirect_to tasks_path, notice: "Vous seul pouvez accéder" unless(current_user.admin || current_user ==  user)
        end
end
