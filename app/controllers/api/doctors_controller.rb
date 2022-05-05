class Api::DoctorsController < ApplicationController
  def index
    @doctors = Doctor.all.includes(:appointments)
    msg = { success: true, data: @doctors }
    render json: msg, status: :ok
  end

  def show
    @doctor = Doctor.find(params[:id])
    msg = { success: true, data: @doctor }
    render json: msg, status: :ok
  end

  def create
    doctor = Doctor.new(doc_params)
    if doctor.valid?
      doctor.save
      msg = { success: true, data: doctor }
      render json: msg, status: :created
    else
      msg = { success: false, errors: doctor.errors.full_messages }
      render json: msg, status: :unprocessable_entity
    end
  end

  def update
    @doctor = Doctor.find(params[:id])
    if @doctor.update(doc_params)
      msg = { success: true, data: @doctor }
      render json: msg, status: :accepted
    else
      msg = { success: false, errors: @doctor.errors.full_messages }
      render json: msg, status: :unprocessable_entity
    end
  end

  def destroy
    @doctor = Doctor.find(params[:id])
    @doctor.destroy
    msg = { success: true, message: 'Deletion Successful.' }
    render json: msg, status: :ok
  end

  private

  def doc_params
    params.permit(:specialization_id, :first_name, :last_name, :email, :phone, :address)
  end
end
