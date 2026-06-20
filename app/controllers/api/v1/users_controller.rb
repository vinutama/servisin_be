module Api
  module V1
    class UsersController < BaseController
      def create
        result = Users::Create.call(user_params)

        if result.success?
          render json: UserSerializer.new(result.user), status: :created
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:username, :name, :email, :password)
      end
    end
  end
end
