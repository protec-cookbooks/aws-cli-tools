unless Dir.exists? "#{node['aws_cli_tools']['iam_tools']['install_path']}"
    remote_file "/tmp/IAMCli.zip" do
        source node['aws_cli_tools']['iam_tools']['source']
        mode "0644"
    end

    directory "#{node['aws_cli_tools']['iam_tools']['install_path']}" do
        owner "root"
        group "root"
        mode 00755
        recursive true
        action :create
    end

    execute "unzip_iam_tools" do
        cwd "/tmp"
        command "unzip IAMCli.zip"
        action :run
    end

    execute "install_iam_tools" do
        cwd "/tmp"
        command "mv IAM*/* #{node['aws_cli_tools']['iam_tools']['install_path']}"
        action :run
    end

    execute "delete_iam_temp" do
        cwd "/tmp"
        command "rm-rf IAM*"
        action :run
    end

    template "/etc/profile.d/iam_tools.sh" do
        source "iam_tools.sh.erb"
        owner "root"
        group "root"
        mode 00755
    end
end