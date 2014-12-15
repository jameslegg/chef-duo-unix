require 'serverspec'

# Required by serverspec
set :backend, :exec

describe 'SSH Daemon' do
  it 'is listening on port 22' do
    expect(port(22)).to be_listening
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

  describe file('/etc/duo/login_duo.conf') do
    it { should be_file }
  end

  describe file('/etc/duo/login_duo.conf') do
    its(:content) { should_not match(/group=\w+/) }
  end

  describe file('/etc/duo/login_duo.conf') do
    its(:content) { should match(/ikey=/) }
  end

  describe file('/etc/duo/login_duo.conf') do
    its(:content) { should match(/ikey=/) }
  end

  describe file('/etc/duo/login_duo.conf') do
    its(:content) { should match(/host=/) }
  end

  describe file('/etc/duo/login_duo.conf') do
    its(:content) { should match('pushinfo=no') }
  end

  describe file('/etc/duo/login_duo.conf') do
    its(:content) { should_not match('autopush=') }
  end

  describe file('/etc/duo/login_duo.conf') do
    its(:content) { should match('failmode=safe') }
  end
end
