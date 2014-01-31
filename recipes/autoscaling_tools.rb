remote_file "/tmp/AutoScaling-2011-01-01.zip" do
    source node['aws_cli_tools']['autoscaling_tools']['source']
    mode "0644"
end

directory "#{node['aws_cli_tools']['autoscaling_tools']['install_path']}" do
    owner "root"
    group "root"
    mode 00755
    recursive true
    action :create
end

execute "unzip_autoscaling_tools" do
    cwd "/tmp"
    command "unzip AutoScaling-2011-01-01.zip -d #{node['aws_cli_tools']['autoscaling_tools']['install_path']}"
    action :run
end

template "/etc/profile.d/autoscaling_tools.sh" do
    source "ami_tools.sh.erb"
    owner "root"
    group "root"
    mode 00755
end