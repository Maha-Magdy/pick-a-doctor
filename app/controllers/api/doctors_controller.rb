class Api::DoctorsController < ApplicationController
  # before_action :authenticate_api_user!

  def index
    @doctors = Doctor.all
    msg = { success: true, data: @doctors.map { |doc| merge_json(doc) } }
    render json: msg, status: :ok
  end

  def show
    @doctor = Doctor.find(params[:id])
    msg = { success: true, data: merge_json(@doctor) }
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
    params.permit(:specialization_id, :first_name, :last_name, :email, :phone, :address, :profile_image)
  end

  def merge_json(doc)
    json_obj = doc.as_json.merge(profile_image: url_for(doc.profile_image)) if doc.profile_image.attached?
    json_obj.merge(specialization: doc.specialization.name)
  end
end
