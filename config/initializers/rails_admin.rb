# frozen_string_literal: true

RailsAdmin.config do |config| # rubocop:disable Metrics/BlockLength
  # internal models
  # https://github.com/sferik/rails_admin/issues/3014
  config.excluded_models = ['ActiveStorage::Blob', 'ActiveStorage::Attachment']

  config.authenticate_with do
    redirect_to(main_app.root_path, flash: {warning: 'You must be signed-in as an administrator to access that page'}) unless signed_in? && current_user.admin?
  end

  config.model 'Reminders' do
    list do
      scopes [nil, :only_deleted]
    end
  end

  config.model 'Thing' do
    list do
      scopes [nil, :adopted, :only_deleted]
    end

    label I18n.t('defaults.thing')

    configure :created_at do
      label 'Drain Import Date'
    end

    configure :city_id do
      label 'Maximo ID'
    end
  end

  config.model 'User' do
    list do
      scopes [nil, :only_deleted]
    end
    configure :created_at do
      label 'Account Creation Date'
    end

    configure :updated_at do
      label 'Last Login'
    end

    update do
      exclude_fields :password, :password_confirmation
    end
  end
end
