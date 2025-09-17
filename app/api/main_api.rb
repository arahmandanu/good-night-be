
class MainApi < Grape::API
  # Build params using object
  mount V1::Main
end
