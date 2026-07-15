require "test_helper"

class TextColumnTest < ActiveSupport::TestCase
  Record = Struct.new(:title, :published_at, :status)

  test "make builds a column and chainables return self" do
    column = Jquard::Tables::Columns::TextColumn.make(:title)

    assert_equal :title, column.name
    assert_same column, column.searchable.sortable.badge.limit(5)
  end

  test "label defaults to the humanized name and accepts overrides" do
    assert_equal "Published at", Jquard::Tables::Columns::TextColumn.make(:published_at).label
    assert_equal "Go-live", Jquard::Tables::Columns::TextColumn.make(:published_at).label("Go-live").label
  end

  test "display_value returns the raw state as string without a formatter" do
    record = Record.new("Hello", nil, nil)

    assert_equal "Hello", Jquard::Tables::Columns::TextColumn.make(:title).display_value(record)
  end

  test "display_value is nil-safe" do
    record = Record.new(nil, nil, nil)

    assert_equal "", Jquard::Tables::Columns::TextColumn.make(:title).date_time.display_value(record)
  end

  test "format block transforms the state" do
    record = Record.new("hello", nil, nil)
    column = Jquard::Tables::Columns::TextColumn.make(:title).format { |state| state.upcase }

    assert_equal "HELLO", column.display_value(record)
  end

  test "date_time formats time-like values" do
    record = Record.new(nil, Time.utc(2026, 7, 3, 9, 15), nil)
    column = Jquard::Tables::Columns::TextColumn.make(:published_at).date_time

    assert_equal "Jul 3, 2026 09:15", column.display_value(record)
  end

  test "the last formatter wins" do
    record = Record.new(nil, Time.utc(2026, 7, 3, 9, 15), nil)
    column = Jquard::Tables::Columns::TextColumn.make(:published_at).date_time.format { |state| state.year.to_s }

    assert_equal "2026", column.display_value(record)
  end

  test "limit truncates after formatting regardless of chain order" do
    record = Record.new(nil, Time.utc(2026, 7, 3, 9, 15), nil)
    column = Jquard::Tables::Columns::TextColumn.make(:published_at).limit(8).date_time

    assert_equal "Jul 3,...", column.display_value(record).delete("…") + "..." if column.display_value(record).include?("…")
    assert_equal 8, column.display_value(record).length
  end

  test "color_for maps states with gray fallback" do
    column = Jquard::Tables::Columns::TextColumn.make(:status).color(published: :success)

    assert_equal :success, column.color_for("published")
    assert_equal :gray, column.color_for("draft")
    assert_equal :gray, Jquard::Tables::Columns::TextColumn.make(:status).color_for("anything")
  end
end
