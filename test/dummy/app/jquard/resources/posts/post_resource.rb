module Jquard
  module Resources
    module Posts
      class PostResource < Jquard::Resource
        self.model = ::Post
        self.navigation_icon = "document-duplicate"

        def self.table(table)
          Tables::PostsTable.configure(table)
        end
      end
    end
  end
end
