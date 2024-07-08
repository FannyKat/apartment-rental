SimpleForm.setup do |config|
  config.wrappers :bulma_form, tag: 'div', class: 'field', error_class: 'field_with_errors', valid_class: 'field_without_errors' do |b|
    b.use :html5
    b.use :placeholder

    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.wrapper tag: 'div', class: 'control' do |input|
      input.use :label, class: 'label'
      input.use :input, class: 'input', error_class: 'is-danger'

      input.use :error, wrap_with: { tag: 'p', class: 'help is-danger' }
      input.use :hint, wrap_with: { tag: 'p', class: 'help is-info' }
    end
  end

  config.default_wrapper = :bulma_form

  config.browser_validations = false

  config.error_notification_tag = :div

  config.error_notification_class = 'error_notification'

end
