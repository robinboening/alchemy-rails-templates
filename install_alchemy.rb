# This rails template installs Alchemy and all depending plugins and gems.
# Run it with +rails YOUR_APP_NAME -d mysql -m install_alchemy+.

# GEM Dependencies for Alchemy

gem 'acts_as_ferret', :version => '0.4.8.2'
gem 'authlogic', :version => '>=2.1.2'
gem 'awesome_nested_set', :version => '>=1.4.3'
gem 'declarative_authorization', :version => '>=0.4.1'
gem "fleximage", :version => ">=1.0.4"
gem 'fast_gettext', :version => '>=0.4.8'
gem 'gettext_i18n_rails', :version => '>=0.2.13'
gem 'gettext', :lib => false, :version => '>=1.9.3'
gem 'rmagick', :lib => "RMagick2", :version => '>=2.12.2'
gem 'jk-ferret', :version => '>=0.11.8.2', :lib => 'ferret'
gem 'will_paginate', :version => '2.3.15'
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

# TODO: We need a generator for adding these two lines into the environment.rb file
#     config.autoload_paths += %W( #{RAILS_ROOT}/vendor/plugins/alchemy/app/sweepers )
#     config.autoload_paths += %W( #{RAILS_ROOT}/vendor/plugins/alchemy/app/middleware )
# When we have this generator, then we can migrate within this script
#rake "db:create"
#rake "db:migrate:alchemy"

run "rm public/index.html"
rake "alchemy:assets:copy:all"

readme = <<EOF
++++++++++++++++++ SUCCESS! Have a lot of fun with Alchemy! ++++++++++++++++++++++
+                                                                                +"
+ Next steps:                                                                    +"
+                                                                                +"
+ 1. Add these two lines into your environment.rb file:                          +"
+                                                                                +"
+ config.autoload_paths += %W( vendor/plugins/alchemy/app/sweepers )             +"
+ config.autoload_paths += %W( vendor/plugins/alchemy/app/middleware )           +"
+                                                                                +"
+ 2. Then create your database and migrate the Alchemy tables:                   +"
+                                                                                +"
+ rake db:create                                                                 +"
+ rake db:migrate:alchemy                                                        +"
+                                                                                +"
+ 3. write this line into your db/seeds.rb:                                      +"
+                                                                                +"
+ Alchemy::Seeder.seed!                                                          +"
+                                                                                +"
+ 4. Seed your database:                                                         +"
+                                                                                +"
+ rake db:seed                                                                   +"
+                                                                                +"
+ 5. Copy Alchemy assets to your public folder:                                  +"
+                                                                                +"
+ rake alchemy:assets:copy:all                                                   +"
+                                                                                +"
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
EOF
puts readme
