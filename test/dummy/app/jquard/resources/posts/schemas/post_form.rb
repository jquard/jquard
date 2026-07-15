module Jquard
  module Resources
    module Posts
      module Schemas
        class PostForm
          include Jquard::Schemas::Components

          def self.configure(schema)
            schema.components([
              Section.make("Content").columns(2).schema([
                TextInput.make(:title).required.max_length(255).column_span_full,
                Select.make(:status).options(draft: "Draft", reviewing: "Reviewing", published: "Published"),
                DateTimePicker.make(:published_at).helper_text("Leave empty for unpublished posts"),
                Toggle.make(:featured),
                Textarea.make(:body).rows(8).column_span_full
              ])
            ])
          end
        end
      end
    end
  end
end
