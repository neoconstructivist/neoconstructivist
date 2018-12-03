activate :aria_current
activate :autoprefixer
activate :external_pipeline,
  name: :webpack,
  command: build? ?  "yarn build" : "yarn start",
  source: ".tmp/dist",
  latency: 1

# Disable warnings
Haml::TempleEngine.disable_option_validator!

set :haml, { format: :html5 }

page "/*.json", layout: false
page "/*.txt", layout: false
page "/*.xml", layout: false
page "/admin/*", layout: "admin"

# Dynamic pages: Methods
data.strategies.each do |id, strategy|
  proxy "/methods/#{strategy.title.parameterize}/index.html",
    "methods/template.html",
    locals: { strategy: strategy },
    ignore: true
end

# Dynamic pages: Projects
data.projects.each_value do |project|
  proxy "/work/#{project.title.parameterize}/index.html",
    "work/template.html",
    locals: { project: project },
    ignore: true
end

# Dynamic pages: Domains
data.projects.each_value do |project|
  if project.respond_to?(:domains)
    project.domains.each do |tag|
      proxy "domains/#{tag.parameterize}/index.html",
        "domains/template.html",
        locals: { domain: tag },
        ignore: true
    end
  end
end

# Dynamic pages: Categories
data.projects.each_value do |project|
  if project.respond_to?(:categories)
    project.categories.each do |tag|
      proxy "categories/#{tag.parameterize}/index.html",
        "categories/template.html",
        locals: { category: tag },
        ignore: true
    end
  end
end

ignore "methods/template.html"
ignore "work/template.html"
ignore "domains/template.html"
ignore "categories/template.html"

configure :development do
  activate :livereload do |reload|
    reload.no_swf = true
  end
end

configure :production do
  activate :gzip
  activate :minify_css
  activate :minify_html
  activate :minify_javascript
end
