### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

RailsAdmin.config do |config|
  config.asset_source = :importmap

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Pundit ==
  config.authorize_with :pundit

  config.authorize_with do
    unless RailsAdminPolicy.new(current_user, nil).dashboard?
      flash[:alert] = t('unauthorized.access')
      redirect_to main_app.root_path
    end
  end

  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    # history_index
    # history_show
  end

  config.model 'OwnershipRequest' do
    list do
      field :tenant
      field :status
      field :cin
      field :created_at
      field :updated_at
    end

    edit do
      field :tenant
      field :status, :enum do
        enum do
          ['pending', 'accepted', 'rejected']
        end
      end
    end
  end
end
