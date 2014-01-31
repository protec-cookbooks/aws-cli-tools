remote_file "/tmp/cloud-search-tools-1.0.0.1-2012.03.05.tar.gz" do
    source node['aws_cli_tools']['cloudsearch_tools']['source']
    mode "0644"
end

directory "#{node['aws_cli_tools']['cloudsearch_tools']['install_path']}" do
    owner "root"
    group "root"
    mode 00755
    recursive true
    action :create
end

execute "untar_cloudsearch_tools" do
    cwd "/tmp"
    command "tar xzvf cloud-search-tools-1.0.0.1-2012.03.05.tar.gz"
    action :run
end

execute "move_cloudsearch_tools" do
    command "mv /tmp/cloud-search-tools-1.0.0.1-2012.03.05/* #{node['aws_cli_tools']['cloudsearch_tools']['install_path']}"
    action :run
end

file "/tmp/cloud-search-tools-1.0.0.1-2012.03.05.tar.gz" do
    action :delete
end

template "/etc/profile.d/cloudsearch_tools.sh" do
    source "ami_tools.sh.erb"
    owner "root"
    group "root"
    mode 00755
end