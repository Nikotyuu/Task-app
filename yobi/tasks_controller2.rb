class TasksController < ApplicationController
  protect_from_forgery
  
  before_action :set_user
  before_action :set_task, only: %i(show edit update destroy)
  before_action :logged_in_user
  before_action :correct_user
  
  def index
    @tasks = @user.tasks
  end

  def show
  end

  def new
    @task = Task.new
  end
  
  def create
    @task = @user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_task_url @user 
    else
      render :new
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def edit
    
  end
  
  def update
    if @task.update_attributes(task_params)
      flash[:success] = "タスクを更新しました。"
      redirect_to user_task_url(@user, @task)
    else
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = "タスクを削除しました。"
    redirect_to user_tasks_url @user
  end
  
  private

    def task_params
      params.require(:task).permit(:name, :description)
    end
    


    def set_user
      @user = User.find_by(params[:id])
    end

    def set_task
      unless @task = @user.tasks.find(params[:id])
        flash[:danger] = "権限がありません。"
        redirect_to user_tasks_url @user
      end
    end
end
