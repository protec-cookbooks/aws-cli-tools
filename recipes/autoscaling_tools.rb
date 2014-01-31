unless Dir.exists? "#{node['aws_cli_tools']['autoscaling_tools']['install_path']}"
    remote_file "/tmp/AutoScaling.zip" do
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

    include_recipe "unzip"

    execute "unzip_autoscaling_tools" do
        cwd "/tmp"
        command "unzip AutoScaling.zip"
        action :run
    end

    execute "install_autoscaling_tools" do
        cwd "/tmp"
        command "mv AutoScaling*/* #{node['aws_cli_tools']['autoscaling_tools']['install_path']}"
        action :run
    end

    execute "delete_autoscaling_temp" do
        cwd "/tmp"
        command "rm -rf AutoScaling*"
        action :run
    end

    template "/etc/profile.d/autoscaling_tools.sh" do
        source "autoscaling_tools.sh.erb"
        owner "root"
        group "root"
        mode 00755
    end
end
