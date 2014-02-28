require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS


RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe "SSH Daemon" do

  it "is listening on port 22" do
    expect(port(22)).to be_listening
  end

  it "has a running server of openssh" do
    expect(service('ssh')).to be_running
  end

  it "should enable ssh TCP forwarding" do
    expect(file('/etc/ssh/sshd_config')).to contain('AllowTcpForwarding yes')
  end

  it "should enable ssh Tunnelling" do
    expect(file('/etc/ssh/sshd_config')).to contain('PermitTunnel yes')
  end

  it "should not enable ForceCommand sshd option" do
    expect(file('/etc/ssh/sshd_config')).not_to contain('ForceCommand')
  end

  it "should install the duo_unix package" do
    expect(package('duo-unix')).to be_installed
  end
end

describe "Duo Unix install" do
  it "should install the duo_unix package" do
    expect(package('duo-unix')).to be_installed
  end

  describe file('/etc/duo/login_duo.conf') do
    it { should be_file }
  end

  describe file('/etc/duo/login_duo.conf') do
    its(:content) { should match("group=duousers") }
  end

  describe file('/etc/duo/login_duo.conf') do
    its(:content) { should match(/ikey=\w+/) }
  end

  describe file('/etc/duo/login_duo.conf') do
    its(:content) { should match(/ikey=\w+/) }
  end

  describe file('/etc/duo/login_duo.conf') do
    its(:content) { should match(/host=api.\w+/) }
  end

  describe file('/etc/duo/login_duo.conf') do
    its(:content) { should match("pushinfo=yes") }
  end

  describe file('/etc/duo/login_duo.conf') do
    its(:content) { should match("autopush=yes") }
  end

  describe file('/etc/duo/login_duo.conf') do
    its(:content) { should match("group=duousers") }
  end

  describe file('/etc/duo/login_duo.conf') do
    its(:content) { should match("failmode=secure") }
  end
end
