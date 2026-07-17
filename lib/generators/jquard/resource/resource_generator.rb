require "rails/generators"

module Jquard
  module Generators
    class ResourceGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)

      def check_model
        model
      rescue NameError
        raise Thor::Error, "Model '#{class_name}' could not be found. Create the model first, then re-run this generator."
      end

      def create_resource_files
        template "resource.rb.tt", File.join(base_dir, "#{file_name}_resource.rb")
        template "table.rb.tt", File.join(base_dir, "tables", "#{plural_file_name}_table.rb")
        template "form.rb.tt", File.join(base_dir, "schemas", "#{file_name}_form.rb")
        template "list_page.rb.tt", File.join(base_dir, "pages", "list_#{plural_file_name}.rb")
        template "create_page.rb.tt", File.join(base_dir, "pages", "create_#{file_name}.rb")
        template "edit_page.rb.tt", File.join(base_dir, "pages", "edit_#{file_name}.rb")
      end

      def show_next_steps
        say ""
        say "#{class_name} resource created. Visit your Jquard panel to see it.", :green
        say ""
      end

      private

      def model
        class_name.constantize
      end

      def base_dir
        File.join("app", "jquard", "resources", plural_file_name)
      end

      def plural_file_name
        file_name.pluralize
      end

      def plural_class_name
        plural_file_name.camelize
      end

      def content_columns
        skipped = [ model.primary_key, "created_at", "updated_at" ]
        model.columns.reject { |column| skipped.include?(column.name) }
      end

      def table_column_declarations
        content_columns.filter_map do |column|
          name = column.name

          if model.defined_enums.key?(name)
            "TextColumn.make(:#{name}).badge"
          else
            case column.type
            when :text then nil
            when :boolean then "IconColumn.make(:#{name}).boolean"
            when :date, :datetime then "TextColumn.make(:#{name}).date_time.sortable"
            when :integer, :decimal, :float then "TextColumn.make(:#{name}).sortable"
            when :string then "TextColumn.make(:#{name}).searchable.sortable"
            else "TextColumn.make(:#{name})"
            end
          end
        end
      end

      def form_field_declarations
        content_columns.map do |column|
          name = column.name

          declaration =
            if (enum = model.defined_enums[name])
              choices = enum.keys.map { |key| "#{key}: #{key.humanize.inspect}" }.join(", ")
              "Select.make(:#{name}).options(#{choices})"
            else
              case column.type
              when :text then "Textarea.make(:#{name}).rows(6).column_span_full"
              when :boolean then "Toggle.make(:#{name})"
              when :date then "DatePicker.make(:#{name})"
              when :datetime then "DateTimePicker.make(:#{name})"
              when :integer, :decimal, :float then "TextInput.make(:#{name}).numeric"
              else "TextInput.make(:#{name})"
              end
            end

          declaration += ".required" if required?(name)
          declaration
        end
      end

      def required?(name)
        model.validators_on(name).any? { |validator| validator.kind == :presence }
      end

      def default_sort?
        model.column_names.include?("created_at")
      end
    end
  end
end
