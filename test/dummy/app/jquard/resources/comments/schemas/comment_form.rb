module Jquard
  module Resources
    module Comments
      module Schemas
        class CommentForm
          include Jquard::Schemas::Components

          def self.configure(schema)
            schema.components([
              Section.make("Details").columns(2).schema([
                TextInput.make(:author_name).required,
                Textarea.make(:body).rows(6).column_span_full,
                Toggle.make(:approved),
                DateTimePicker.make(:posted_at)
              ])
            ])
          end
        end
      end
    end
  end
end
