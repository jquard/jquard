require "test_helper"

class IconColumnTest < ActiveSupport::TestCase
  Record = Struct.new(:featured)

  test "make builds a column and chainables return self" do
    column = Jquard::Tables::Columns::IconColumn.make(:featured)

    assert_equal :featured, column.name
    assert_same column, column.boolean
  end

  test "boolean flag defaults to off" do
    assert_not Jquard::Tables::Columns::IconColumn.make(:featured).boolean?
    assert Jquard::Tables::Columns::IconColumn.make(:featured).boolean.boolean?
  end

  test "state_for reads the record attribute" do
    column = Jquard::Tables::Columns::IconColumn.make(:featured)

    assert_equal true, column.state_for(Record.new(true))
    assert_equal false, column.state_for(Record.new(false))
  end
end
