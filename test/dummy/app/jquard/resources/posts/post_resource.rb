module Jquard
  module Resources
    module Posts
      class PostResource < Jquard::Resource
        self.model = ::Post
        self.navigation_icon = "document-duplicate"

        def self.form(schema)
          Schemas::PostForm.configure(schema)
        end

        def self.table(table)
          Tables::PostsTable.configure(table)
        end

        def self.pages
          {
            index: Pages::ListPosts,
            create: Pages::CreatePost,
            edit: Pages::EditPost
          }
        end
      end
    end
  end
end
