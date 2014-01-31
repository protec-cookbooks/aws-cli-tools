unless Dir.exists? "#{node['aws_cli_tools']['cloudsearch_tools']['install_path']}"
    remote_file "/tmp/cloud-search-tools.tar.gz" do
        source node['aws_cli_tools']['cloudsearch_tools']['source']
        mode "0644"
    end

    directory "#{node['aws_cli_tools']['cloudsearch_tools']['install_path']}" do
        owner "root"
        group "root"
        mode 00755
        recursive true
        action :create
    end

    execute "untar_cloudsearch_tools" do
        cwd "/tmp"
        command "tar xzvf cloud-search-tools.tar.gz --strip-components=1 -C #{node['aws_cli_tools']['cloudsearch_tools']['install_path']}"
        action :run
    end

    file "/tmp/cloud-search-tools-1.0.0.1-2012.03.05.tar.gz" do
        action :delete
    end

    template "/etc/profile.d/cloudsearch_tools.sh" do
        source "cloudsearch_tools.sh.erb"
        owner "root"
        group "root"
        mode 00755
    end
end
