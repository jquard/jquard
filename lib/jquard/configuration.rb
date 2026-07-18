module Jquard
  class Configuration
    RUBY_RED = {
      50 => "#fdf4f3",
      100 => "#fce7e5",
      200 => "#f9d2cf",
      300 => "#f4b0ab",
      400 => "#ec817a",
      500 => "#df574e",
      600 => "#cc342d",
      700 => "#ab2822",
      800 => "#8e2420",
      900 => "#762421",
      950 => "#400f0d"
    }.freeze

    PALETTES = { ruby: RUBY_RED }.freeze

    REQUIRED_SHADES = [ 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950 ].freeze

    attr_accessor :brand_name, :current_user_method, :sign_out_path, :sign_out_method
    attr_reader :primary_color, :primary_color_palette, :authenticate

    def initialize
      @brand_name = "Jquard"
      self.primary_color = :ruby
    end

    def authenticate_with(&block)
      raise Jquard::Error, "authenticate_with requires a block" unless block

      @authenticate = block
    end

    def primary_color=(value)
      @primary_color_palette =
        if value.is_a?(Hash)
          missing = REQUIRED_SHADES - value.keys
          if missing.any?
            raise Jquard::Error, "Palette hash is missing shades: #{missing.join(", ")}. All of #{REQUIRED_SHADES.join(", ")} are required."
          end

          value
        else
          PALETTES.fetch(value.to_sym) do
            raise Jquard::Error, "Unknown palette #{value.inspect}. Available: #{PALETTES.keys.join(", ")}, or pass a Hash of shades."
          end
        end
      @primary_color = value
    end
  end
end
