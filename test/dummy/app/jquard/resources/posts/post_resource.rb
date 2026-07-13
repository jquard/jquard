class Jquard::Resources::Posts::PostResource < Jquard::Resource
  self.model = ::Post
  self.navigation_icon = 'document-duplicate'
end
