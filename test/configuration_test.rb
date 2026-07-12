require "test_helper"

class ConfigurationTest < ActiveSupport::TestCase
  test "defaults to the ruby palette and Jquard brand" do
    config = Jquard::Configuration.new

    assert_equal "Jquard", config.brand_name
    assert_equal :ruby, config.primary_color
    assert_equal "#cc342d", config.primary_color_palette[600]
  end

  test "accepts a custom palette hash with all shades" do
    config = Jquard::Configuration.new
    palette = Jquard::Configuration::REQUIRED_SHADES.index_with { "#123456" }
    config.primary_color = palette

    assert_equal "#123456", config.primary_color_palette[600]
  end

  test "rejects a palette hash with missing shades" do
    config = Jquard::Configuration.new

    error = assert_raises(Jquard::Error) { config.primary_color = { 600 => "#123456" } }
    assert_match(/missing shades: 50, 100/, error.message)
  end

  test "rejects unknown palette names" do
    config = Jquard::Configuration.new

    assert_raises(Jquard::Error) { config.primary_color = :mauve }
  end
end
