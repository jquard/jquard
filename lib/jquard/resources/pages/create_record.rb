module Jquard
  module Resources
    module Pages
      class CreateRecord < Page
        def title
          "Create #{resource.singular_label.downcase}"
        end

        def mutate_form_data_before_create(data)
          data
        end

        def handle_record_creation(model, data)
          record = model.new(data)
          record.save
          record
        end

        def after_create(record)
        end

        def redirect_url_after_create(record)
          nil
        end

        def created_notification_message
          "#{resource.singular_label} created"
        end
      end
    end
  end
end
