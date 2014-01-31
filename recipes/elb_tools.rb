remote_file "/tmp/ElasticLoadBalancing.zip" do
    source node['aws_cli_tools']['elb_tools']['source']
    mode "0644"
end

directory "#{node['aws_cli_tools']['elb_tools']['install_path']}" do
    owner "root"
    group "root"
    mode 00755
    recursive true
    action :create
end

execute "unzip_elb_tools" do
    cwd "/tmp"
    command "unzip ElasticLoadBalancing.zip -d #{node['aws_cli_tools']['elb_tools']['install_path']}"
    action :run
end

template "/etc/profile.d/elb_tools.sh" do
    source "ami_tools.sh.erb"
    owner "root"
    group "root"
    mode 00755
end