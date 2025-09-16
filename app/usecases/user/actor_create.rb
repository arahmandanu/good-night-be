class Usecases::User::ActorCreate
  Schema = Dry::Validation.Params do
    required(:name).filled(:string)
  end

  def initialize(params)
    @params = params
  end

  def call
    validation = Schema.call(@params)

    if validation.success?
      user = ::User.new(validation.output)

      if user.save
        Result.success(user)
      else
        Result.failure(user.errors.full_messages)
      end
    else
      Result.failure(validation.errors.to_h)
    end
  end
end
