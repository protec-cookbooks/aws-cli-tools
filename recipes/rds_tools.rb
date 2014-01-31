remote_file "/tmp/RDSCli.zip" do
    source node['aws_cli_tools']['rds_tools']['source']
    mode "0644"
end

directory "#{node['aws_cli_tools']['rds_tools']['install_path']}" do
    owner "root"
    group "root"
    mode 00755
    recursive true
    action :create
end

execute "unzip_rds_tools" do
    cwd "/tmp"
    command "unzip RDSCli.zip -d #{node['aws_cli_tools']['rds_tools']['install_path']}"
    action :run
end

template "/etc/profile.d/rds_tools.sh" do
    source "ami_tools.sh.erb"
    owner "root"
    group "root"
    mode 00755
end