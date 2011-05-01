# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.authors = ["David Ruyer", "Benjamin Roth"]
  s.email = ["david.ruyer@gmail.com", "benjamin.roth@peachyweb.com"]
  s.homepage = "https://github.com/MrRuru/rails_form_autosave"
  s.name = "rails_form_autosave"
  s.summary = "Allows the user to navigate away from an unfinished form, and have it's fields restored when coming back."
  s.description = "Allows the user to navigate away from an unfinished form, and have it's fields restored when coming back."
  s.files = Dir["{app,lib,config,public}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.rdoc"]
  s.version = "0.0.5"
end