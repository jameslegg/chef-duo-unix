# A non comprehensive list of pre built packages available from Duo Security
# https://www.duosecurity.com/docs/duounix#linux-distribution-packages
default['duo_unix']['debian']['wheezy']['repo_url'] = 'http://pkg.duosecurity.com/Debian'
default['duo_unix']['debian']['wheezy']['repo_gpg'] = 'https://www.duosecurity.com/APT-GPG-KEY-DUO'
default['duo_unix']['ubuntu']['precise']['repo_url'] = 'http://pkg.duosecurity.com/Ubuntu'
default['duo_unix']['ubuntu']['precise']['repo_gpg'] = 'https://www.duosecurity.com/APT-GPG-KEY-DUO'
# Set to true to force install from source
default['duo_unix']['from_source'] = false
default['duo_unix']['url'] = 'https://dl.duosecurity.com/duo_unix-'
default['duo_unix']['version']  = '1.9.7'
default['duo_unix']['checksum'] = '8fc90eed4924cf23a8e1ea275be81f345932954a'
default['duo_unix']['configure_options'] = %W{--prefix=/usr}
default['duo_unix']['pam_configure_options'] = " --with-pam"

# If you want to use the PAM module
default['duo_unix']['conf']['pam_module'] = false

# duo_unix configuration options
default['duo_unix']['conf']['integration_key'] = ''
default['duo_unix']['conf']['secret_key'] = ''
default['duo_unix']['conf']['api_hostname'] = ''
default['duo_unix']['conf']['pushinfo'] = 'no'
default['duo_unix']['conf']['autopush'] = false
default['duo_unix']['conf']['group'] = ''
default['duo_unix']['conf']['failmode'] = 'safe'
default['duo_unix']['conf']['PermitTunnel'] = false
default['duo_unix']['conf']['AllowTCPForwarding'] = false
default['duo_unix']['conf']['login_duo_enabled'] = true
