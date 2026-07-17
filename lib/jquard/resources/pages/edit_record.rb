module Jquard
  module Resources
    module Pages
      class EditRecord < Page
        def title
          "Edit #{resource.singular_label.downcase}"
        end

        def mutate_form_data_before_fill(data)
          data
        end

        def mutate_form_data_before_save(data)
          data
        end

        def handle_record_update(record, data)
          record.update(data)
        end

        def after_save(record)
        end

        def redirect_url_after_save(record)
          nil
        end

        def saved_notification_message
          "Saved"
        end
      end
    end
  end
end
