unless Dir.exists? "#{node['aws_cli_tools']['ami_tools']['install_path']}"
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

    include_recipe "unzip"

    execute "unzip_ami_tools" do
        cwd "/tmp"
        command "unzip ec2-ami-tools.zip"
        action :run
    end

    execute "install_ami_tools" do
        cwd "/tmp"
        command "mv ec2-ami-tools*/* #{node['aws_cli_tools']['ami_tools']['install_path']}"
        action :run
    end

    execute "delete_ami_temp" do
        cwd "/tmp"
        command "rm -rf ec2-ami-tools*"
        action :run
    end

    template "/etc/profile.d/ami_tools.sh" do
        source "ami_tools.sh.erb"
        owner "root"
        group "root"
        mode 00755
    end
end
