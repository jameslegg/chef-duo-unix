#
# Cookbook Name:: duo_unix
# Recipe:: default
#
# Copyright 2013, Hung Truong
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe 'openssh'

case node[:platform]
when "debian", "ubuntu"
	package "libssl-dev" do
		action :upgrade
	end
	package "make" do
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
end

bash "build-and-install-duo_unix" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
  tar -xzvf duo_unix-#{version}.tar.gz
  (cd duo_unix-#{version} && ./configure #{configure_options})
  (cd duo_unix-#{version} && make && make install)
  EOF
end

# Set up the config file
template "/etc/duo/login_duo.conf" do
  source "login_duo.conf.erb"
  mode 0600
  owner "sshd"
  group "root"
end

# Enable login_duo for ssh
if node['duo_unix']['conf']['login_duo_enabled']
	bash "require login_duo for ssh" do
		code <<-WTAF
		grep -q 'ForceCommand /usr/sbin/login_duo' /etc/ssh/sshd_config || echo 'ForceCommand /usr/sbin/login_duo' >> /etc/ssh/sshd_config
		WTAF
	end
else
	bash "disable login_duo for ssh" do
		code <<-WTAF
		sed -i '\#ForceCommand /usr/sbin/login_duo#d' /etc/ssh/sshd_config
		WTAF
	end
end

# Set sshd_config variables by overrding openssh cookbook variables
if node['duo_unix']['conf']['PermitTunnel']
    node.override['openssh']['server']['permit_tunnel'] = 'yes'
else
    node.override['openssh']['server']['permit_tunnel'] = 'no'
end

if node['duo_unix']['conf']['AllowTcpForwarding']
    node.override['openssh']['server']['allow_tcp_forwarding'] = 'no'
else
    node.override['openssh']['server']['allow_tcp_forwarding'] = 'yes'
end
