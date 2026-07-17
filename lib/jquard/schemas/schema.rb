module Jquard
  module Schemas
    class Schema
      def components(list = nil)
        return @components ||= [] if list.nil?

        @components = list
        self
      end

      def fields
        collect_fields(components)
      end

      def field_names
        fields.map(&:name)
      end

      def apply_defaults(record)
        fields.each do |field|
          next if field.default.nil? || !record[field.name].nil?

          record[field.name] = field.default
        end
        record
      end

      def apply_default_fields(model)
        return self if components.any?

        skipped = [ model.primary_key, "created_at", "updated_at" ]
        components(model.columns.reject { |column| skipped.include?(column.name) }.map { |column| default_field_for(model, column) })
      end

      private

      def collect_fields(list)
        list.flat_map do |component|
          component.is_a?(Fields::Field) ? component : collect_fields(component.schema)
        end
      end

      def default_field_for(model, column)
        name = column.name.to_sym

        if (enum = model.defined_enums[column.name])
          Fields::Select.make(name).options(enum.keys.index_with(&:humanize))
        else
          case column.type
          when :text then Fields::Textarea.make(name)
          when :boolean then Fields::Toggle.make(name)
          when :date then Fields::DatePicker.make(name)
          when :datetime then Fields::DateTimePicker.make(name)
          when :integer, :decimal, :float then Fields::TextInput.make(name).numeric
          else Fields::TextInput.make(name)
          end
        end
      end
    end
  end
end
