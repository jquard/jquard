require "test_helper"

class QueryTest < ActiveSupport::TestCase
  def build_table
    Jquard::Tables::Table.new.columns([
      Jquard::Tables::Columns::TextColumn.make(:title).searchable.sortable,
      Jquard::Tables::Columns::TextColumn.make(:status)
    ]).default_sort(:created_at, :desc)
  end

  def run_query(params = {})
    Jquard::Tables::Query.new(table: build_table, scope: Post.all, params: params).result
  end

  test "search matches searchable columns only" do
    result = run_query(q: "Review")

    assert_equal [ posts(:reviewing_post) ], result.records.to_a
    assert_equal 1, result.total_count
  end

  test "search escapes like wildcards" do
    result = run_query(q: "%")

    assert_equal 0, result.total_count
  end

  test "sorts by whitelisted columns" do
    result = run_query(sort: "title", direction: "desc")

    assert_equal "title", result.sort
    assert_equal "desc", result.direction
    assert_equal posts(:published_post), result.records.first
  end

  test "ignores non-sortable and unknown sort params" do
    result = run_query(sort: "status", direction: "asc")

    assert_nil result.sort
  end

  test "invalid direction falls back to asc" do
    result = run_query(sort: "title", direction: "sideways")

    assert_equal "asc", result.direction
  end

  test "paginates with clamped page numbers" do
    12.times { |i| Post.create!(title: "Bulk post #{i}") }

    result = run_query(page: "2")
    assert_equal 15, result.total_count
    assert_equal 2, result.pages
    assert_equal 2, result.page
    assert_equal 5, result.records.length
    assert_equal 11, result.from
    assert_equal 15, result.to

    assert_equal 2, run_query(page: "999").page
    assert_equal 1, run_query(page: "-3").page
  end

  test "per_page only honors whitelisted options" do
    assert_equal 10, run_query(per_page: "9999").per_page
    assert_equal 25, run_query(per_page: "25").per_page
  end

  test "empty result reports zero range" do
    result = run_query(q: "no such thing anywhere")

    assert_equal 0, result.total_count
    assert_equal 0, result.from
    assert_equal 0, result.to
    assert_equal 1, result.pages
  end
end
