module Jquard
  module Resources
    module Comments
      module Tables
        class CommentsTable
          include Jquard::Tables::Components

          def self.configure(table)
            table
              .columns([
                TextColumn.make(:author_name).searchable.sortable,
                IconColumn.make(:approved).boolean,
                TextColumn.make(:posted_at).date_time.sortable
              ])
              .record_actions([ EditAction.make, DeleteAction.make ])
              .default_sort(:created_at, :desc)
          end
        end
      end
    end
  end
end
