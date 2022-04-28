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
    doctor = Doctor.new(specialization_id: doc_params[:specialization_id], first_name: doc_params[:first_name], last_name: doc_params[:last_name],
      email: doc_params[:email], phone: doc_params[:phone], address: doc_params[:address])
    if doctor.valid?
      doctor.save
      respond_to do |format|
        msg = { status: 'ok', message: 'Success!' }
        format.json { render json: msg } # don't do msg.to_json
      end
    else
      respond_to do |format|
        msg = { status: 'fail', message: 'Failed!' }
        format.json { render json: msg } # don't do msg.to_json
      end
    end
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
