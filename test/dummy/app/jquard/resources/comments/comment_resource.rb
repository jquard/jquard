module Jquard
  module Resources
    module Comments
      class CommentResource < Jquard::Resource
        self.model = ::Comment

        def self.form(schema)
          Schemas::CommentForm.configure(schema)
        end

        def self.table(table)
          Tables::CommentsTable.configure(table)
        end

        def self.pages
          {
            index: Pages::ListComments,
            create: Pages::CreateComment,
            edit: Pages::EditComment
          }
        end
      end
    end
  end
end
