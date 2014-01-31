remote_file "/tmp/ec2-api-tools.zip" do
    source node['aws_cli_tools']['api_tools']['source']
    mode "0644"
end

directory "#{node['aws_cli_tools']['api_tools']['install_path']}" do
    owner "root"
    group "root"
    mode 00755
    recursive true
    action :create
end

execute "unzip_api_tools" do
    cwd "/tmp"
    command "unzip ec2-api-tools.zip -d #{node['aws_cli_tools']['api_tools']['install_path']}"
    action :run
end

template "/etc/profile.d/api_tools.sh" do
    source "api_tools.sh.erb"
    owner "root"
    group "root"
    mode 00755
end