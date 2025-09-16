
class MainApi < Grape::API
  # Build params using object
  helpers V1::Helpers

  mount V1::Main
end
