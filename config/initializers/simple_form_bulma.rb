SimpleForm.setup do |config|
  config.wrappers :bulma, class: 'field', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :label, class: 'label'

    b.use :input, class: 'input', wrap_with: { tag: 'div', class: 'control' }

    b.use :full_error, wrap_with: { tag: 'p', class: 'help is-danger' }

    b.use :hint, wrap_with: { tag: 'p', class: 'help is-info' }
  end

  config.default_wrapper = :bulma
end
