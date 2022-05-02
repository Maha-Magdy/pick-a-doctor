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
    doctor = Doctor.new(doc_params)
    if doctor.valid?
      doctor.save
      respond_to do |format|
        msg = { status: 'ok', message: 'Created Successfully.' }
        format.json { render json: msg } # don't do msg.to_json
      end
    else
      respond_to do |format|
        msg = { status: 'fail', message: 'Failed.' }
        format.json { render json: msg } # don't do msg.to_json
      end
    end
  end

  def update
    @doctor = Doctor.find(params[:id])
    if @doctor.update(doc_params)
      respond_to do |format|
        msg = { status: 'ok', message: 'Updated Successfully.' }
        format.json { render json: msg } # don't do msg.to_json
      end
    else
      respond_to do |format|
        msg = { status: 'fail', message: 'Update Failed' }
        format.json { render json: msg } # don't do msg.to_json
      end
    end
  end

  def destroy
    @doctor = Doctor.find(params[:id])
    @doctor.destroy
    respond_to do |format|
      msg = { status: 'ok', message: 'Deletion Successful.' }
      format.json { render json: msg } # don't do msg.to_json
    end
  end

  private

  def doc_params
    params.permit(:specialization_id, :first_name, :last_name, :email, :phone, :address)
  end
end
