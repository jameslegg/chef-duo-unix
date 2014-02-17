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
end
