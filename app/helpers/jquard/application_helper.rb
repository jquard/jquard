module Jquard
  module ApplicationHelper
    def jquard_navigation
      Jquard.registry.resources
        .sort_by { |resource| [ resource.navigation_sort, resource.navigation_label ] }
        .group_by(&:navigation_group)
        .sort_by { |group, _| [ group.nil? ? 0 : 1, group.to_s ] }
    end

    def jquard_icon(name, css_class: nil)
      Jquard::Icons.render(name, css_class: css_class).html_safe
    end

    def jquard_theme_style
      variables = Jquard.config.primary_color_palette
        .map { |shade, value| "--jq-primary-#{shade}: #{value};" }
        .join(" ")

      tag.style(":root { #{variables} }".html_safe)
    end
  end
end
