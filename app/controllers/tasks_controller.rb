class TasksController < ApplicationController
  #def index
  # @tasks = current_user.tasks.order("importance ASC").all
  #  respond_to do |format|
  #    format.html{render 'tasks/index'}
  #    format.json{render :json => {tasks: @tasks}}
  # end
  #end

  def index
    @tasks = current_user.tasks.order("expiry").all
    respond_to do |format|
      format.html {  }
      format.json { render json: @tasks, status: :ok}
    end
  end

  def create
    task = current_user.tasks.create( task_create_params)

    respond_to do |format|
      format.html { redirect_to '/' }
      format.json { render json: task, status: :ok}
    end
  end

  def update
    task = current_user.tasks.find_by(id: params[:id])
    if task && params[:task]
      task.update!(task_update_params)
    end

    respond_to do |format|
      format.html { redirect_to '/' }
      format.json { render json: task, status: :ok}
    end
  end

  def delete
    task = current_user.tasks.find_by(id: params[:id])
    if task
      task.destroy!
      respond_to do |format|
        format.html { }
        format.json { render json: task, status: :ok}
      end
    end

    respond_to do |format|
      format.html { }
      format.json { render status: :unprocessable_entity}
    end
  end

  def edit
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      respond_to do |format|
        format.html { redirect_to '/' }
        format.json { render status: :ok}
      end
    end
    respond_to do |format|
      format.html {  }
      format.json { render json: @task, status: :ok}
    end
  end

  def task_update_params
    params.require(:task).permit(:name, :description, :importance, :expiry, :done)
  end


  def task_create_params
    params.require(:task).permit(:name, :description, :importance, :expiry, :done)
  end
end

