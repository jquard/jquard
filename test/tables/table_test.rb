require "test_helper"

class TableTest < ActiveSupport::TestCase
  test "columns acts as setter with chaining and reader" do
    table = Jquard::Tables::Table.new
    column = Jquard::Tables::Columns::TextColumn.make(:title)

    assert_same table, table.columns([ column ])
    assert_equal [ column ], table.columns
  end

  test "default_sort reads nil until set" do
    table = Jquard::Tables::Table.new

    assert_nil table.default_sort
    table.default_sort(:created_at, :desc)
    assert_equal [ :created_at, :desc ], table.default_sort
  end

  test "searchable and sortable lookups respect column flags" do
    title = Jquard::Tables::Columns::TextColumn.make(:title).searchable.sortable
    status = Jquard::Tables::Columns::TextColumn.make(:status)
    table = Jquard::Tables::Table.new.columns([ title, status ])

    assert_equal [ title ], table.searchable_columns
    assert table.searchable?
    assert_equal title, table.sortable_column("title")
    assert_nil table.sortable_column("status")
    assert_nil table.sortable_column("nonexistent")
  end

  test "apply_default_columns fills empty tables from the model" do
    table = Jquard::Tables::Table.new.apply_default_columns(Post)

    assert_equal Post.column_names.size, table.columns.size
    assert(table.columns.all? { |column| column.is_a?(Jquard::Tables::Columns::TextColumn) })
  end

  test "apply_default_columns leaves configured tables alone" do
    column = Jquard::Tables::Columns::TextColumn.make(:title)
    table = Jquard::Tables::Table.new.columns([ column ]).apply_default_columns(Post)

    assert_equal [ column ], table.columns
  end
end
