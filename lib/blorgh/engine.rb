# if you want to immediately require dependencies when the engine
# is required, you should require them before the engine's initialization.
# require 'other_engine/engine'
# require 'yet_another_engine/engine'

module Blorgh
  class Engine < ::Rails::Engine
    isolate_namespace Blorgh

    # Because these decorators are not referenced by your Rails application
    # itself, Rails' autoloading system will not kick in and load your
    # decorators. This means that you need to require them yourself.
    config.to_prepare do
      Dir.glob(Rails.root + "app/decorators/**/*_decorator*.rb").each do |c|
        require_dependency(c)
      end
    end

    # add engine assets to precompiled path when those
    # assets are not explicitly required by the main app
    initializer "blorgh.assets.precompile" do |app|
      app.config.assets.precompile += %w(admin.css admin.js)
    end
  end
end
