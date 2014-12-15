# A non comprehensive list of pre built packages available from Duo Security
# https://www.duosecurity.com/docs/duounix#linux-distribution-packages
default['duo_unix']['debian']['wheezy']['repo_url'] = \
  'http://pkg.duosecurity.com/Debian'
default['duo_unix']['debian']['wheezy']['repo_gpg'] = \
  'https://www.duosecurity.com/APT-GPG-KEY-DUO'
default['duo_unix']['ubuntu']['precise']['repo_url'] = \
  'http://pkg.duosecurity.com/Ubuntu'
default['duo_unix']['ubuntu']['precise']['repo_gpg'] = \
  'https://www.duosecurity.com/APT-GPG-KEY-DUO'
# Set to true to force install from source
default['duo_unix']['from_source'] = false
default['duo_unix']['url'] = 'https://dl.duosecurity.com/duo_unix-'
default['duo_unix']['version']  = '1.9.7'
default['duo_unix']['checksum'] = \
  'f200ea5accf3eafce66568ecb6f9f99634e84fac987bc06df11bd21e6dea1324'
default['duo_unix']['configure_options'] = %w(--prefix=/usr)

# duo_unix configuration options
default['duo_unix']['conf']['integration_key'] = ''
default['duo_unix']['conf']['secret_key'] = ''
default['duo_unix']['conf']['api_hostname'] = ''
default['duo_unix']['conf']['pushinfo'] = 'no'
default['duo_unix']['conf']['group'] = ''
default['duo_unix']['conf']['failmode'] = 'safe'
default['duo_unix']['conf']['PermitTunnel'] = false
default['duo_unix']['conf']['AllowTCPForwarding'] = false
default['duo_unix']['conf']['login_duo_enabled'] = true
