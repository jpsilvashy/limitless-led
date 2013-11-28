require 'spec_helper'

describe LimitlessLed do

  let(:params) { {} }

  subject { LimitlessLed::Bridge.new(params) }

  describe 'can be initialized with default values' do
    its(:host) { should == 'localhost' }
    its(:port) { should == 8899 }
  end

  describe 'can be initialized with a host and port' do
    let(:params) { { host: '192.168.100.100', port: 6666 } }

    its(:host) { should == '192.168.100.100' }
    its(:port) { should == 6666 }
  end

  describe '#color' do
    it 'changes color' do
      # subject.should_receive(:send_packet).with("\x40\xFF\x55")
    end
  end

  describe '#send_packet' do
    it 'should create a new socket and send the packet' do

      fake_socket = double(:fake_udp_socket)
      fake_socket.should_receive(:connect).with( subject.host, subject.port )
      fake_socket.should_receive(:send).with('stuff', 0)

      UDPSocket.should_receive(:new) { fake_socket }

      subject.send(:send_packet, 'stuff')

    end
  end

end


