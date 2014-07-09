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

end
