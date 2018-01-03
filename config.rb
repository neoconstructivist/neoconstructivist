activate :aria_current
activate :autoprefixer

# Disable warnings
Haml::TempleEngine.disable_option_validator!

set :css_dir, "assets/stylesheets"
set :fonts_dir, "assets/fonts"
set :images_dir, "assets/images"
set :js_dir, "assets/javascripts"
set :markdown,
  autolink: true,
  fenced_code_blocks: true,
  footnotes: true,
  highlight: true,
  smartypants: true,
  strikethrough: true,
  tables: true,
  with_toc_data: true
set :markdown_engine, :redcarpet
set :haml, { format: :html5 }

page "/*.json", layout: false
page "/*.txt", layout: false
page "/*.xml", layout: false

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

ignore "methods/template.html"
ignore "work/template.html"

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
