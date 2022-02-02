class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    def index
        campers = Camper.all
        render json: campers
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper, serializer: CamperWithActivitiesSerializer
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end

    private

    def render_not_found
        render json: {error: "Camper not found"}, status: :not_found
    end

    def render_unprocessable_entity
        render json: { errors: invalid.record.errors}, status: :unprocessable_entity
    end

    def camper_params
        params.permit(:name, :age)
    end
end
