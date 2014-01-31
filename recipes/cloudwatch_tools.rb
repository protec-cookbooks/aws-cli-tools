unless Dir.exists? "#{node['aws_cli_tools']['cloudwatch_tools']['install_path']}"
    remote_file "/tmp/CloudWatch.zip" do
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
        command "unzip CloudWatch.zip"
        action :run
    end

    execute "install_cloudwatch_tools" do
        cwd "/tmp"
        command "mv CloudWatch*/* #{node['aws_cli_tools']['cloudwatch_tools']['install_path']}"
        action :run
    end

    execute "delete_cloudwatch_temp" do
        cwd "/tmp"
        command "rm-rf CloudWatch*"
        action :run
    end

    template "/etc/profile.d/cloudwatch_tools.sh" do
        source "cloudwatch_tools.sh.erb"
        owner "root"
        group "root"
        mode 00755
    end
end