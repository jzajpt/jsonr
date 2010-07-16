require 'jsonr/generator'

if defined?(::ActionView)
  require 'jsonr/template_handler'

  # Hook into ActionView, register jsonr extension.
  ::ActionView::Template.register_template_handler :jsonr, Jsonr::TemplateHandler
end

