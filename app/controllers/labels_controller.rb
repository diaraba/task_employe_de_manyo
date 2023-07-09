class LabelsController < ApplicationController
    before_action :set_label, only: [:show, :edit, :update, :destroy]

    # GET /labels
    # GET /labels.json
    def index
      @labels = current_user.labels
    end
  
    # GET /labels/1
    # GET /labels/1.json
    def show
    end
  
    # GET /labels/new
    def new
      @label = Label.new
    end
  
    # GET /labels/1/edit
    def edit
    end
  
    # POST /labels
    # POST /labels.json
    def create
      @label = Label.new(label_params)
  
        if @label.save
          flash[:notice]=t('flash.labels.create')
          redirect_to labels_path
        else
          render :new
        end
    end
  
    # PATCH/PUT /labels/1
    # PATCH/PUT /labels/1.json
    def update
    
        if @label.update(label_params)
          flash[:notice]=t('flash.labels.update')
          redirect_to labels_path
        else
          render :edit
        end
    end
  
    # DELETE /labels/1
    # DELETE /labels/1.json
    def destroy
      @label.destroy
      
        flash[:notice]=t('flash.labels.destroy')
        redirect_to labels_path
      
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_label
        @label =Label.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def label_params
        params.require(:label).permit(:name, :user_id)
      end
end
