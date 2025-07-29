# frozen_string_literal: true

say_status :tailwind, "Installing Tailwind CSS..."

confirm = ask "This configuration will ovewrite your existing #{"postcss.config.js".bold.white}. Would you like to continue? [Yn]"
return unless confirm.casecmp?("Y")

run "npm install tailwindcss @tailwindcss/postcss --save-dev"

create_file "postcss.config.js", <<~JS, force: true
  export default {
    plugins: {
      '@tailwindcss/postcss': {},
      'postcss-flexbugs-fixes': {},
      'postcss-preset-env': {
        autoprefixer: {
          flexbox: 'no-2009'
        },
        stage: 3
      }
    }
  }
JS

css_imports = <<~CSS
  /* If you need to add @import statements, do so up here */

  @import "jit-refresh.css"; /* triggers frontend rebuilds */

  /* Set up Tailwind imports */
  @import "tailwindcss";

CSS

if File.exist?("frontend/styles/index.css")
  prepend_to_file "frontend/styles/index.css", css_imports
else
  say "\nPlease add the following lines to your CSS index file:"
  say css_imports
end

create_file "frontend/styles/jit-refresh.css", "/* #{Time.now.to_i} */"

insert_into_file "Rakefile",
                  after: %r{  task :(build|dev) do\n} do
  <<-JS
    sh "touch frontend/styles/jit-refresh.css"
  JS
end

if File.exist?(".gitignore")
  append_to_file ".gitignore" do
    <<~FILES

      frontend/styles/jit-refresh.css
    FILES
  end
end

create_builder "tailwind_jit.rb" do
  <<~'RUBY'
    class Builders::TailwindJit < SiteBuilder
      def build
        return if ARGV.include?("--skip-tw-jit")

        fast_refreshing = false

        hook :site, :fast_refresh do
          fast_refreshing = true
        end

        hook :site, :post_write do
          if fast_refreshing
            fast_refreshing = false
            Thread.new do
              sleep 0.75
              refresh_file = site.in_root_dir("frontend", "styles", "jit-refresh.css")
              File.write refresh_file, "/* #{Time.now.to_i} */"
            end
          end
        end
      end
    end
  RUBY
end

say_status :tailwind, "Tailwind CSS is now configured."
