class Api::DoctorsController < ApplicationController
  def index
    @doctors = Doctor.all.includes(:appointments)
    render json: @doctors
  end

  def show
    @doctor = Doctor.find(params[:id])
    render json: @doctor
  end

  def create
  end

  def update
  end

  def delete
  end

  private

  def doc_params
    params.permit(:specialization_id, :first_name, :last_name, :email, :phone, :address)
  end
end
