require "mini_chef"
require "pry"

current_path = File.dirname(__FILE__)
MiniChef.define do

  template "/etc/nginx/nginx.conf" do
    source File.expand_path("../templates/nginx/nginx.conf.erb", current_path)
    owner "root"
    group "root"
    mode 0644
  end

  template "/etc/nginx/sites-available/default" do
    source File.expand_path("../templates/nginx/site-availables-default.erb", current_path)
    owner "root"
    group "root"
    mode 0644
  end

  directory "/etc/nginx/certificates/" do
    owner "root"
    group "root"
    mode 0755
  end

  template "/etc/nginx/certificates/myssl.crt" do
    source File.expand_path("../templates/nginx/ssl-dev.crt", current_path)
    owner "root"
    group "root"
    mode 0644
  end

  template "/etc/nginx/certificates/myssl.key" do
    source File.expand_path("../templates/nginx/ssl-dev.key", current_path)
    owner "root"
    group "root"
    mode 0644
  end

  execute "sudo service nginx restart"

  replace "#{ENV['HOME']}/.zshrc" do
    what /^ZSH_THEME.*$/
    with %{ZSH_THEME="clean"}
  end

  replace "#{ENV['HOME']}/.zshrc" do
    what /\Z/ #append at the end of the document
    with %{
      alias rs="bundle exec rails s"
      alias rc="bundle exec rails c"
      alias rt="bundle exec rspec spec"
      alias rcu="bundle exec cucumber"

      alias bs="bin/rails s"
      alias bc="bin/rails c"
      alias bt="bin/rspec spec"
      alias bcu="bin/cucumber"

      function gdd {
        grep -inIEr --color=ALWAYS $1 $2
      }
    }
  end

end
