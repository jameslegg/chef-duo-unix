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
include_recipe 'duo_unix::install'

directory '/etc/duo'
# If using login_duo set up sshd and login_duo.conf
if node['duo_unix']['conf']['login_duo_enabled']
  node.override['openssh']['server']['force_command'] = '/usr/sbin/login_duo'
  template '/etc/duo/login_duo.conf' do
    source 'duo.conf.erb'
    mode 0600
    owner 'sshd'
    group 'root'
  end
end

# If using PAM setup pam config
template '/etc/duo/pam_duo.conf' do
  source 'duo.conf.erb'
  mode 0600
  owner 'root'
  group 'root'
  only_if { node['duo_unix']['conf']['pam_enabled'] }
end

# Set sshd_config variables by overriding openssh cookbook variables
if node['duo_unix']['conf']['PermitTunnel']
  node.override['openssh']['server']['permit_tunnel'] = 'yes'
else
  node.override['openssh']['server']['permit_tunnel'] = 'no'
end

if node['duo_unix']['conf']['AllowTCPForwarding']
  node.override['openssh']['server']['allow_tcp_forwarding'] = 'yes'
else
  node.override['openssh']['server']['allow_tcp_forwarding'] = 'no'
end
