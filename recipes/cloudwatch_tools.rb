remote_file "/tmp/CloudWatch-2010-08-01.zip" do
    source node['aws_cli_tools']['cloudwatch_tools']['source']
    mode "0644"
end

directory "#{node['aws_cli_tools']['cloudwatch_tools']['install_path']}" do
    owner "root"
    group "root"
    mode 00755
    recursive true
    action :create
end

execute "unzip_cloudwatch_tools" do
    cwd "/tmp"
    command "unzip CloudWatch-2010-08-01.zip -d #{node['aws_cli_tools']['cloudwatch_tools']['install_path']}"
    action :run
end

template "/etc/profile.d/cloudwatch_tools.sh" do
    source "ami_tools.sh.erb"
    owner "root"
    group "root"
    mode 00755
end