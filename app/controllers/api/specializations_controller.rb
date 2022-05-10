class Api::SpecializationsController < ApplicationController
  include Response

  before_action :authenticate_api_user!

  def new
    @specialization = Specialization.new
    json_response(@specialization)
  end

  def index
    @specializations = Specialization.all
    json_response(@specializations)
  end

  def create
    @specialization = Specialization.new(specialization_params)

    if @specialization.save
      json_response(@specialization)
    else
      json_response(@specialization.errors, :unprocessable_entity)
    end
  end

  def show
    @specialization = Specialization.find(params[:id])
    msg = { success: true, data: @specialization, doctors: @specialization.doctors }
    render json: msg, status: :ok
  end

  def edit
    @specialization = Specialization.find(params[:id])
  end

  def update
    @specialization = Specialization.find(params[:id])

    if @specialization.update(name: params[:name])
      json_response(@specialization)
    else
      json_response(@specialization.errors, :unprocessable_entity)
    end
  end

  def destroy
    @specialization = Specialization.find(params[:id])

    if @specialization
      @specialization.destroy
      json_response('Specialization has been deleted.')
    else
      json_response(@specialization.errors, :unprocessable_entity)
    end
  end

  private

  def specialization_params
    params.permit(:name)
  end
end
