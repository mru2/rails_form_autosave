# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "rails_form_autosave"
  s.summary = "Automatically save your form contents."
  s.description = "Automatically save your form contents."
  s.files = Dir["{app,lib,config,javascripts}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.rdoc"]
  s.version = "0.0.2"
end