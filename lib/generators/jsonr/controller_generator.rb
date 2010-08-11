# encoding: utf-8

module Jsonr

  class ControllerGenerator < Rails::Generators::NamedBase

    source_root File.expand_path('../templates', File.dirname(__FILE__))

    argument :actions, :type => :array, :default => [], :banner => "action action"

    class_option :template_engine, :desc => "Template engine to generate view files"
    class_option :controllers, :type => :boolean, :default => true
    class_option :views,       :type => :boolean, :default => true

    def create_controller_files
      return unless options[:controllers]

      template 'controller.rb', "app/controllers/#{file_path}_controller.rb"
    end

    private

    def class_name
      super.singularize
    end

    def dir_name
      file_name.underscore.pluralize
    end
    alias :collection_name :dir_name

    def var_name
      file_name.underscore.singularize
    end

  end

end