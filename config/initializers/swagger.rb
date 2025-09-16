GrapeSwaggerRails.options.before_action do |request|
   GrapeSwaggerRails.options.app_name = "Good Night API"

  # Default is v1
  GrapeSwaggerRails.options.app_url = "/api/v1/"
  GrapeSwaggerRails.options.url     = "doc"


  GrapeSwaggerRails.options.hide_url_input     = true
  GrapeSwaggerRails.options.hide_api_key_input = true
  GrapeSwaggerRails.options.validator_url      = nil
end
