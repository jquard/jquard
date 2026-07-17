require "test_helper"
require "rails/generators"
require "generators/jquard/install/install_generator"

class InstallGeneratorTest < Rails::Generators::TestCase
  tests Jquard::Generators::InstallGenerator
  destination File.expand_path("../../../tmp/generators", __dir__)

  setup do
    prepare_destination
    FileUtils.mkdir_p(File.join(destination_root, "config"))
    File.write(File.join(destination_root, "config/routes.rb"), "Rails.application.routes.draw do\nend\n")
  end

  test "mounts the engine and creates the initializer" do
    run_generator

    assert_file "config/routes.rb", /mount Jquard::Engine => "\/admin"/
    assert_file "config/initializers/jquard.rb" do |content|
      assert_match(/Jquard.configure do \|config\|/, content)
      assert_match(/config.brand_name = "Dummy"/, content)
      assert_match(/config.primary_color/, content)
    end
  end

  test "mount path is configurable" do
    run_generator [ "--path=backoffice" ]

    assert_file "config/routes.rb", /mount Jquard::Engine => "\/backoffice"/
  end
end
