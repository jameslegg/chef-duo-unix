require 'serverspec'

# Required by serverspec
set :backend, :exec

describe 'SSH Daemon' do
  it 'is listening on port 22' do
    expect(port(22)).to be_listening
  end

  it 'has a running server of openssh' do
    expect(service('ssh')).to be_running
  end

  it 'should disable ssh TCP forwarding' do
    expect(file('/etc/ssh/sshd_config')).to contain('AllowTcpForwarding no')
  end

  it 'should disable ssh Tunnelling' do
    expect(file('/etc/ssh/sshd_config')).to contain('PermitTunnel no')
  end

  it 'should enable login_duo ForceCommand in sshd_config' do
    expect(file('/etc/ssh/sshd_config')).to contain(
      'ForceCommand /usr/sbin/login_duo'
    )
  end
end
