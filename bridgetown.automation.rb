# frozen_string_literal: true

say_status :tailwind, "Installing Tailwind CSS..."

run "npm install tailwindcss @tailwindcss/cli --save-dev"

css_imports = <<~CSS
  @import 'tailwindcss' source(none);
  @source '../';
  @source '../../config';
  @source '../../plugins';
  @source '../../src';
CSS

create_file "frontend/styles/tailwind.css", css_imports

insert_into_file "Rakefile",
                  after: %r{  task :(build) do\n} do
  <<-RUBY
    sh "bin/tailwindcss"
  RUBY
end

append_to_file "Rakefile" do
  <<~RUBY
    Rake::Task['frontend:watcher'].enhance do
      Bridgetown::Utils::Aux.run_process(
        'Tailwind',
        :blue,
        'bin/tailwindcss --watch'
      )
    end
  RUBY
end

get "#{__dir__}/tailwindcss", "bin/tailwindcss"
chmod "bin/tailwindcss", 0755

gsub_file 'config/esbuild.defaults.js', /const manifest = {/ do |match|
  match << ' "styles/tailwind.css":"tailwind.css" '
end

say_status :tailwind, "Tailwind CSS is now configured."
say_status :tailwind, 'Use `asset_path "styles/tailwind.css"` in your templates to load the CSS file.'
