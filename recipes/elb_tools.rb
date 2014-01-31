unless Dir.exists? "#{node['aws_cli_tools']['elb_tools']['install_path']}"
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
        command "unzip ElasticLoadBalancing.zip"
        action :run
    end

    execute "install_elb_tools" do
        cwd "/tmp"
        command "mv ElaticLoadBalancing*/* #{node['aws_cli_tools']['elb_tools']['install_path']}"
        action :run
    end

    execute "delete_elb_temp" do
        cwd "/tmp"
        command "rm-rf ElasticLoadBalancing*"
        action :run
    end

    template "/etc/profile.d/elb_tools.sh" do
        source "elb_tools.sh.erb"
        owner "root"
        group "root"
        mode 00755
    end
end