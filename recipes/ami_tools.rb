remote_file "/tmp/ec2-ami-tools.zip" do
    source node['aws_cli_tools']['ami_tools']['source']
    mode "0644"
end

directory "#{node['aws_cli_tools']['ami_tools']['install_path']}" do
    owner "root"
    group "root"
    mode 00755
    recursive true
    action :create
end

execute "unzip_ami_tools" do
    cwd "/tmp"
    command "unzip ec2-ami-tools.zip -d #{node['aws_cli_tools']['ami_tools']['install_path']}"
    action :run
end