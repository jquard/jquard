adjectives = %w[Modern Practical Hidden Essential Surprising Timeless Bold Quiet Radical Everyday]
topics = [
  "Rails Engines", "Hotwire Patterns", "Admin Panels", "SQLite in Production",
  "View Components", "Turbo Frames", "Ruby Idioms", "Tailwind Theming",
  "Database Design", "Open Source Maintenance"
]

bodies = [
  "There is a moment in every project where the tooling either carries you or buries you.",
  "We started with a single model and a generator. Everything else grew from there.",
  "Convention over configuration is not about writing less — it is about deciding less.",
  "The best admin panel is the one nobody has to think about.",
  "Weaving a UI from configuration objects feels like cheating, in the best way."
]

adjectives.each_with_index do |adjective, i|
  topics.each_with_index do |topic, j|
    n = i * topics.length + j
    status = %i[draft reviewing published][n % 3]

    Post.find_or_create_by!(title: "#{adjective} #{topic}") do |post|
      post.body = bodies[n % bodies.length]
      post.status = status
      post.featured = (n % 7).zero?
      post.published_at = status == :published ? Time.zone.now - n.days : nil
    end
  end
end

puts "Seeded #{Post.count} posts."
