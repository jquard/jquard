module Jquard
  module Resources
    module Posts
      module Tables
        class PostsTable
          include Jquard::Tables::Components

          def self.configure(table)
            table
              .columns([
                TextColumn.make(:title).searchable.sortable,
                TextColumn.make(:status).badge.color(draft: :gray, reviewing: :warning, published: :success),
                IconColumn.make(:featured).boolean,
                TextColumn.make(:published_at).date_time.sortable
              ])
              .record_actions([ EditAction.make, DeleteAction.make ])
              .default_sort(:created_at, :desc)
          end
        end
      end
    end
  end
end
