require "test_helper"

class SchemaTest < ActiveSupport::TestCase
  test "components acts as setter with chaining and reader" do
    schema = Jquard::Schemas::Schema.new
    field = Jquard::Schemas::Fields::TextInput.make(:title)

    assert_same schema, schema.components([ field ])
    assert_equal [ field ], schema.components
  end

  test "fields flattens nested layouts" do
    title = Jquard::Schemas::Fields::TextInput.make(:title)
    status = Jquard::Schemas::Fields::Select.make(:status)
    body = Jquard::Schemas::Fields::Textarea.make(:body)

    schema = Jquard::Schemas::Schema.new.components([
      Jquard::Schemas::Layouts::Section.make("Content").schema([
        title,
        Jquard::Schemas::Layouts::Grid.make(2).schema([ status ])
      ]),
      body
    ])

    assert_equal [ title, status, body ], schema.fields
    assert_equal [ :title, :status, :body ], schema.field_names
  end

  test "apply_defaults fills only nil attributes" do
    schema = Jquard::Schemas::Schema.new.components([
      Jquard::Schemas::Fields::TextInput.make(:title).default("Untitled"),
      Jquard::Schemas::Fields::Toggle.make(:featured).default(true)
    ])

    record = Post.new(featured: false)
    schema.apply_defaults(record)

    assert_equal "Untitled", record.title
    assert_equal false, record.featured
  end

  test "apply_default_fields maps column types and enums" do
    schema = Jquard::Schemas::Schema.new.apply_default_fields(Post)
    fields = schema.fields.index_by(&:name)

    assert_not_includes fields.keys, :id
    assert_not_includes fields.keys, :created_at
    assert_instance_of Jquard::Schemas::Fields::TextInput, fields[:title]
    assert_instance_of Jquard::Schemas::Fields::Textarea, fields[:body]
    assert_instance_of Jquard::Schemas::Fields::Select, fields[:status]
    assert_equal %w[draft reviewing published], fields[:status].options.keys
    assert_instance_of Jquard::Schemas::Fields::Toggle, fields[:featured]
    assert_instance_of Jquard::Schemas::Fields::DateTimePicker, fields[:published_at]
  end

  test "apply_default_fields leaves configured schemas alone" do
    field = Jquard::Schemas::Fields::TextInput.make(:title)
    schema = Jquard::Schemas::Schema.new.components([ field ]).apply_default_fields(Post)

    assert_equal [ field ], schema.components
  end
end
