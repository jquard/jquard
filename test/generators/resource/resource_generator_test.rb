require "test_helper"
require "rails/generators"
require "generators/jquard/resource/resource_generator"

class ResourceGeneratorTest < Rails::Generators::TestCase
  tests Jquard::Generators::ResourceGenerator
  destination File.expand_path("../../../tmp/generators", __dir__)
  setup :prepare_destination

  test "generates the full resource file tree" do
    run_generator [ "Post" ]

    assert_file "app/jquard/resources/posts/post_resource.rb" do |content|
      assert_match(/module Jquard\n  module Resources\n    module Posts\n      class PostResource < Jquard::Resource/, content)
      assert_match(/self\.model = ::Post/, content)
      assert_match(/Schemas::PostForm\.configure\(schema\)/, content)
      assert_match(/Tables::PostsTable\.configure\(table\)/, content)
      assert_match(/index: Pages::ListPosts/, content)
    end

    assert_file "app/jquard/resources/posts/pages/list_posts.rb", /class ListPosts < Jquard::Resources::Pages::ListRecords/
    assert_file "app/jquard/resources/posts/pages/create_post.rb", /class CreatePost < Jquard::Resources::Pages::CreateRecord/
    assert_file "app/jquard/resources/posts/pages/edit_post.rb", /class EditPost < Jquard::Resources::Pages::EditRecord/
  end

  test "table columns are introspected from the model" do
    run_generator [ "Post" ]

    assert_file "app/jquard/resources/posts/tables/posts_table.rb" do |content|
      assert_match(/TextColumn\.make\(:title\)\.searchable\.sortable/, content)
      assert_match(/TextColumn\.make\(:status\)\.badge/, content)
      assert_match(/IconColumn\.make\(:featured\)\.boolean/, content)
      assert_match(/TextColumn\.make\(:published_at\)\.date_time\.sortable/, content)
      assert_match(/record_actions\(\[ EditAction\.make, DeleteAction\.make \]\)/, content)
      assert_match(/default_sort\(:created_at, :desc\)/, content)
      assert_no_match(/:body/, content)
      assert_no_match(/:id\b/, content)
      assert_no_match(/:created_at\)/, content)
    end
  end

  test "form fields are introspected from the model" do
    run_generator [ "Post" ]

    assert_file "app/jquard/resources/posts/schemas/post_form.rb" do |content|
      assert_match(/Section\.make\("Details"\)\.columns\(2\)/, content)
      assert_match(/TextInput\.make\(:title\)\.required/, content)
      assert_match(/Select\.make\(:status\)\.options\(draft: "Draft", reviewing: "Reviewing", published: "Published"\)/, content)
      assert_match(/Toggle\.make\(:featured\)/, content)
      assert_match(/DateTimePicker\.make\(:published_at\)/, content)
      assert_match(/Textarea\.make\(:body\)\.rows\(6\)\.column_span_full/, content)
    end
  end

  test "fails helpfully when the model does not exist" do
    stderr = capture(:stderr) { run_generator [ "Widget" ] }

    assert_match(/Model 'Widget' could not be found/, stderr)
    assert_no_file "app/jquard/resources/widgets/widget_resource.rb"
  end

  test "generated files parse as valid ruby" do
    run_generator [ "Post" ]

    Dir.glob(File.join(destination_root, "app/jquard/**/*.rb")).each do |file|
      assert RubyVM::InstructionSequence.compile_file(file), "#{file} failed to parse"
    end
  end
end
