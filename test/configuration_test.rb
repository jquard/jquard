require "test_helper"

class ConfigurationTest < ActiveSupport::TestCase
  test "defaults to the ruby palette and Jquard brand" do
    config = Jquard::Configuration.new

    assert_equal "Jquard", config.brand_name
    assert_equal :ruby, config.primary_color
    assert_equal "#cc342d", config.primary_color_palette[600]
  end

  test "accepts a custom palette hash" do
    config = Jquard::Configuration.new
    config.primary_color = { 600 => "#123456" }

    assert_equal "#123456", config.primary_color_palette[600]
  end

  test "rejects unknown palette names" do
    config = Jquard::Configuration.new

    assert_raises(Jquard::Error) { config.primary_color = :mauve }
  end
end
