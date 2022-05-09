class Api::AppointmentsController < ApplicationController
  include Response

  before_action :authenticate_api_user!

  def index
    @appointments = Appointment.all
    json_response(@appointments)
  end

  def user_appointments
    @appointments = Appointment.where(user_id: params[:id]).ordered_by_most_recent
    json_response(@appointments)
  end

  def doctor_appointments
    @appointments = Appointment.where(doctor_id: params[:id]).ordered_by_most_recent
    json_response(@appointments)
  end

  def create
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      json_response(@appointment)
    else
      json_response(@appointment.errors, :unprocessable_entity)
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
    json_response(@appointment)
  end

  def update
    @appointment = Appointment.find(params[:id])

    if @appointment.update(appointment_params)
      json_response(@appointment)
    else
      json_response(@appointment.errors, :unprocessable_entity)
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])

    if @appointment
      @appointment.destroy
      json_response('Appointment has been deleted.')
    else
      json_response(@specialization.errors, :unprocessable_entity)
    end
  end

  private

  def appointment_params
    params.permit(:user_id, :doctor_id, :date, :notes)
  end
end
