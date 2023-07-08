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
        tasks = tasks.search_status(params[:search][:status]) if params[:search][:status].present?
        tasks = tasks.search_title(params[:search][:title]) if params[:search][:title].present?
        tasks = tasks.search_label_id(params[:search][:label_id]) if params[:search][:label_id].present?
      end
  
      @tasks = tasks.page(params[:page]).per(10)
      @labels = current_user.labels.pluck(:name, :id)
    end
  
    def new
      @task = Task.new
    end
  
    def create
      @task = Task.new(task_params)
      if @task.save
        @task.label_ids = params[:task][:label_ids]
        flash[:notice]=t('flash.tasks.create')
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
        @task.label_ids = params[:task][:label_ids]
        flash[:notice]=t('flash.tasks.update')
        redirect_to tasks_path
      else
        render :edit
      end
    end
  
    def destroy
      @task.destroy
      flash[:notice]=t('flash.tasks.destroy')
      redirect_to tasks_path
    end
  
    private
  
      def set_task
        @task = Task.find(params[:id])
      end
  
      def task_params
        params.require(:task).permit(:title, :content, :created_at, :deadline_on, :priority, :status, :user_id,:label_ids)
      end
  
      def correct_user
        @task=Task.find(params[:id])
        redirect_to tasks_path, notice:  "Vous n'êtes pas autorisé à accéder" unless current_owmner?(@task)
      end 
end  