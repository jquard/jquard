require "test_helper"

class ResourceTest < ActiveSupport::TestCase
  test "resources register themselves under their derived slug" do
    assert_equal Jquard::Resources::Posts::PostResource, Jquard.registry.fetch("posts")
  end

  test "slug is derived from the class name" do
    assert_equal "posts", Jquard::Resources::Posts::PostResource.slug
  end

  test "registry fetch falls back for unknown slugs" do
    assert_equal :fallback, Jquard.registry.fetch("nope") { :fallback }
  end

  test "anonymous subclasses are not registered" do
    slugs_before = Jquard.registry.slugs.dup
    Class.new(Jquard::Resource)

    assert_equal slugs_before, Jquard.registry.slugs
  end
end
