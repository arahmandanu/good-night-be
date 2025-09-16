
class MainApi < Grape::API
  # Build params using object
  include Grape::Extensions::Hashie::Mash::ParamBuilder
  mount V1::Main
end
