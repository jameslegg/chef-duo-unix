#
# Cookbook Name:: duo_unix
# Recipe:: source
#
# Will install duo_security from source
#
case node['platform']
when "debian", "ubuntu"
	package "libssl-dev" do
		action :upgrade
	end
	package "build-essential" do
		action :upgrade
	end
end

# Install duo_unix from source
configure_options = node['duo_unix']['configure_options'].join(" ")
version = node['duo_unix']['version']
remote_file "#{Chef::Config[:file_cache_path]}/duo_unix-#{version}.tar.gz" do
  source "#{node['duo_unix']['url']}#{version}.tar.gz"
  checksum node['duo_unix']['checksum']
  mode "0644"
  notifies :run, "bash[build-and-install-duo_unix]"
end

bash "build-and-install-duo_unix" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
  tar -xzvf duo_unix-#{version}.tar.gz
  (cd duo_unix-#{version} && ./configure #{configure_options})
  (cd duo_unix-#{version} && make && make install)
  EOF
  # Only build when notified that a file has been re-downloaded
  action :nothing
end
