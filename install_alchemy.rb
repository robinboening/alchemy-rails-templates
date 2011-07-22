# This rails template installs Alchemy and all depending plugins and gems.
# Run it with +rails YOUR_APP_NAME -d mysql -m install_alchemy+.

# GEM Dependencies for Alchemy
gem 'acts_as_ferret', :version => '0.4.8.2'
gem 'authlogic', :version => '~>2'
gem 'awesome_nested_set', :version => '>=1.4.3'
gem 'declarative_authorization', :version => '>=0.4.1'
gem "fleximage", :version => ">=1.0.4"
gem 'fast_gettext', :version => '>=0.4.8'
gem 'gettext_i18n_rails', :version => '~>0.2'
gem 'gettext', :lib => false, :version => '>=1.93.0'
gem 'rmagick', :lib => "RMagick2", :version => '>=2.12.2'
gem 'jk-ferret', :version => '>=0.11.8.2', :lib => 'ferret'
gem 'will_paginate', :version => '~>2.3'
gem 'mimetype-fu', :version => '>=0.1.2', :lib => 'mimetype_fu'

rake 'gems:install'

# Installing a lot of plugins for Alchemy
plugin "acts_as_list", :git => "git://github.com/rails/acts_as_list.git"
plugin "alchemy", :git => "git://github.com/magiclabs/alchemy.git"
plugin "attachment_fu", :git => "git://github.com/technoweenie/attachment_fu.git"
plugin "i18n_label", :git => "git://github.com/iain/i18n_label.git"
plugin "jrails", :git => "git://github.com/aaronchi/jrails.git"
plugin "tinymce_hammer", :git => "git://github.com/tvdeyen/tinymce_hammer.git -r rails2"
plugin "userstamp", :git => "git://github.com/delynn/userstamp.git"

auto_load_paths = %q{  config.autoload_paths += %W(  #{RAILS_ROOT}/vendor/plugins/alchemy/app/sweepers )\n  config.autoload_paths += %W( #{RAILS_ROOT}/vendor/plugins/alchemy/app/middleware )}
run "awk '{print}/Add additional load paths/{print \"#{auto_load_paths}\"}' './config/environment.rb' > './config/environment.tmp'"
run "mv './config/environment.tmp' './config/environment.rb'"

# Folder/File creation for using alchemy with individual layouts and elements?
if yes?("\n##################\nDo you want to use alchemy with individual settings, elements and layouts?\n(folders/files will be created)\n(y/n)")
  rake("alchemy:app_structure:create:all")
  # Generate page_layouts and elements?
  generate(:page_layouts) if yes?("\n##################\nDo you want to create all page_layouts defined from alchemy's standardset?\n(files will be created in '/app/views/page_layouts/')\n(y/n)")
  generate(:elements) if yes?("\n##################\nDo you want to create all elements defined from alchemy's standardset?\n(files will be created in '/app/views/elements/')\n(y/n)")
end

rake "db:create"
rake "db:migrate:alchemy"

File.open("./db/seeds.rb", "w") do |seedfile|
   seedfile.puts "Alchemy::Seeder.seed!"
end
rake "db:seed"

rake "alchemy:assets:copy:all"
run "rm public/index.html"

puts "++++++++++++++++++ SUCCESS! Have a lot of fun with Alchemy! ++++++++++++++++++++++"
