class TasksController < ApplicationController
    before_action :correct_user, only: [:show, :edit, :update]
    before_action :set_task, only: %i[ show edit update destroy ]
  
    def index
      if params[:sort_deadline_on]
        tasks = Task.sort_deadline_on.sort_created_at
      elsif params[:sort_priority]
        tasks = Task.sort_priority.sort_created_at
      else
        tasks = Task.sort_created_at
      end
      
      if params[:search].present?
        if params[:search][:status].present? && params[:search][:title].present?
          tasks = tasks.search_status(params[:search][:status]).search_title(params[:search][:title])
        elsif params[:search][:status].present?
          tasks = tasks.search_status(params[:search][:status])
        elsif params[:search][:title].present?
          tasks = tasks.search_title(params[:search][:title])
        end
      end
  
      @tasks = tasks.page(params[:page]).per(10)
    end
  
    def new
      @task = Task.new
    end
  
    def create
      @task = Task.new(task_params)
      if @task.save
        flash[:notice]=t('flash.create')
        redirect_to tasks_path
      else
        render :new
      end
    end
  
    def show
    end
  
    def edit
    end
  
    def update
      if @task.update(task_params)
        flash[:notice]=t('flash.update')
        redirect_to tasks_path
      else
        render :edit
      end
    end
  
    def destroy
      @task.destroy
      flash[:notice]=t('flash.delete')
      redirect_to tasks_path
    end
  
    private
  
      def set_task
        @task = Task.find(params[:id])
      end
  
      def task_params
        params.require(:task).permit(:title, :content, :created_at, :deadline_on, :priority, :status, :user_id)
      end
  
      def correct_user
        @task=Task.find(params[:id])
        redirect_to tasks_path, notice:  "Vous n'êtes pas autorisé à accéder" unless current_owmner?(@task)
      end 
end  