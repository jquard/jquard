module Jquard
  module ApplicationHelper
    def jquard_navigation
      (jquard_page_navigation_items + jquard_resource_navigation_items)
        .sort_by { |item| [ item.sort, item.label ] }
        .group_by(&:group)
        .sort_by { |group, _| [ group.nil? ? 0 : 1, group.to_s ] }
    end

    def jquard_page_navigation_items
      Jquard.registry.pages.select(&:visible?).map do |page|
        Jquard::Navigation::Item.new(
          label: page.navigation_label,
          icon: page.navigation_icon,
          path: page.route_path == "/" ? root_path : page_path(page.slug),
          group: page.navigation_group,
          sort: page.navigation_sort,
          exact: true
        )
      end
    end

    def jquard_resource_navigation_items
      Jquard.registry.resources.map do |resource|
        Jquard::Navigation::Item.new(
          label: resource.navigation_label,
          icon: resource.navigation_icon,
          path: resource_path(resource.slug),
          group: resource.navigation_group,
          sort: resource.navigation_sort
        )
      end
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

    def jquard_current_user
      method = Jquard.config.current_user_method
      return unless method && controller.respond_to?(method)

      controller.send(method)
    end

    def jquard_user_name(user)
      user.try(:name).presence || user.try(:email).presence || user.to_s
    end

    def jquard_user_initials(user)
      name = jquard_user_name(user).to_s
      name = name.split("@").first.to_s if name.include?("@")
      name.split(/[\s._-]+/).filter_map { |part| part[0] }.join[0, 2].to_s.upcase
    end

    def jquard_sign_out_path
      path = Jquard.config.sign_out_path
      return instance_exec(&path) if path.respond_to?(:call)

      path.presence
    end

    def jquard_sign_out_method
      Jquard.config.sign_out_method || :delete
    end
  end
end
