class ListsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    @list = List.for(current_user).new
  end

  def create
    @list = List.for(current_user).new(list_params)
    if @list.save
      redirect_to lists_path
    else
      render :new
    end
  end

  def edit
    @list = List.for(current_user).find(params[:id])
  rescue
    redirect_to lists_path
  end

  def update
    @list = List.for(current_user).find(params[:id])
    if @list.update_attributes(list_params)
      redirect_to lists_path
    else
      render :edit
    end
  rescue
    redirect_to lists_path
  end

  def destroy
    @list = List.for(current_user).find params[:id]
    @list.destroy!
  rescue
    render json: { error: 'Cannot delete list' }, status: :unprocessable_entity
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
