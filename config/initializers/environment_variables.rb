module EnvironmentVariablesExample
  class Application < Rails::Application
    config.before_configuration do
      return if Rails.env.production?
      env_file = Rails.root.join("config", 'environment_variables.yml').to_s

      if File.exists?(env_file)
        YAML.load_file(env_file)[Rails.env].each do |key, value|
          ENV[key.to_s] = value
        end # end YAML.load_file
      end # end if File.exists?
    end # end config.before_configuration
  end # end class
end # end module