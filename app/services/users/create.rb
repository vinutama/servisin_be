# app/services/users/create.rb
module Users
    class Create
    Result = Struct.new(:success?, :user, :errors, keyword_init: true)

    def self.call(params)
        new(params).call
    end

    def initialize(params)
        @params = params
    end

    def call
        user = User.new(@params)

        if user.save
        Result.new(success?: true, user: user, errors: [])
        else
        Result.new(success?: false, user: user, errors: user.errors.full_messages)
        end
    end
    end
end
