class Api::DoctorsController < ApplicationController
  def index
    @doctors = Doctor.all.includes(:appointments)
    render json: @doctors
  end

  def show
  end

  def create
  end

  def update
  end

  def delete
  end
end
