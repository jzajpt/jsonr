require 'jsonr'

# Hook into ActionView, register jsonr extension.
ActionView::Template.register_template_handler :jsonr, Jsonr::TemplateHandler
