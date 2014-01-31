unless Dir.exists? "#{node['aws_cli_tools']['rds_tools']['install_path']}"
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
        command "unzip RDSCli.zip"
        action :run
    end

    execute "install_rds_tools" do
        cwd "/tmp"
        command "mv RDS*/* #{node['aws_cli_tools']['rds_tools']['install_path']}"
        action :run
    end

    execute "delete_rds_temp" do
        cwd "/tmp"
        command "rm-rf RDS*"
        action :run
    end

    template "/etc/profile.d/rds_tools.sh" do
        source "rds_tools.sh.erb"
        owner "root"
        group "root"
        mode 00755
    end
end