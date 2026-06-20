# app/controllers/api/v1/ping_controller.rb
module Api
    module V1
    class PingController < BaseController
        def index
            render json: { message: "Pong" }
            end
    end
    end
end
