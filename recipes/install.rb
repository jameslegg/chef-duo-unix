#
# Cookbook Name:: duo_unix
# Recipe:: install
#

if node['duo_unix']['from_source']
  include_recipe 'duo_unix::source'
else
  case node['platform']
  when 'debian', 'ubuntu'
    lsb_codename = node['lsb']['codename']
    platform = node['platform']
    if node['duo_unix'][platform][lsb_codename]
      if node['duo_unix'][platform][lsb_codename]['repo_url']
        apt_repository "duosecurity" do
          uri node['duo_unix'][platform][lsb_codename]['repo_url']
          distribution lsb_codename
          components ['main']
          key node['duo_unix'][platform][lsb_codename]['repo_gpg']
        end
        package "duo-unix"
      else
        # If no supported repo defined this release install from source
        include_recipe 'duo_unix::source'
      end
    else
      include_recipe 'duo_unix::source'
    end
  else
      # If no pkg for OS try and install from source
      include_recipe 'duo_unix::source'
  end
end
