module Jsonr

  class TemplateHandler < ActionView::TemplateHandler

    include ActionView::TemplateHandlers::Compilable

    def compile(template)
      "@template_format = :html;" +
      "controller.response.content_type ||= Mime::JSON;" +
      "Jsonr::Generator.new{ |page| #{template.source} }.to_s"
    end

  end

end