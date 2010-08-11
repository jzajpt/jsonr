# encoding: utf-8

module Jsonr

  class ViewsGenerator < Rails::Generators::Base

    source_root File.expand_path('../templates', File.dirname(__FILE__))

    argument :name, :type => :string
    argument :actions, :type => :array, :default => [], :banner => "action action"

    def generate_views
      empty_directory File.join("app", "views", dir_name)

      do_actions = actions.empty? ? %w( index show new create edit update destroy ) : actions

      do_actions.each do |action|
        template "#{action}.json.jsonr", "app/views/#{dir_name}/#{action}.json.jsonr"
      end
    end

    private

    def dir_name
      name.underscore.pluralize
    end
    alias :collection_name :dir_name

    def var_name
      name.underscore.singularize
    end

  end

end