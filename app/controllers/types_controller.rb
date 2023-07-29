class TypesController < ApplicationController
  def index
    types = Type.all
    render json: types
  end

  def show
    type = Type.find_by(id: params[:id]) || Type.find_by(name: params[:name])
    render json: type
  end
end
