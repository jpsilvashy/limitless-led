# Tests should cover these commands, which can also be found here:
# http://www.limitlessled.com/dev/

# All UDP Commands are 3 Bytes. First byte is from the list below, plus a fixed 2 byte suffix of 0x00 (decimal: 0) and 0x55 (decimal: 85)
# i.e. to turn all RGBW COLOR LimitlessLED Smart lights to ON then send the TCP/IP UDP packet of:  0x42 0x00 0x55
#
#                           Hexidecimal (byte)	 Decimal (integer)
#
# RGBW COLOR LED ALL OFF	        0x41	           65
# RGBW COLOR LED ALL ON	          0x42	           66
#
# DISCO SPEED SLOWER	            0x43	           67
# DISCO SPEED FASTER	            0x44	           68
#
# GROUP 1 ALL ON		              0x45	           69	(SYNC/PAIR RGB+W Bulb within 2 seconds of Wall Switch Power being turned ON)
# GROUP 1 ALL OFF		              0x46	           70
# GROUP 2 ALL ON		              0x47	           71	(SYNC/PAIR RGB+W Bulb within 2 seconds of Wall Switch Power being turned ON)
# GROUP 2 ALL OFF		              0x48	           72
# GROUP 3 ALL ON		              0x49	           73	(SYNC/PAIR RGB+W Bulb within 2 seconds of Wall Switch Power being turned ON)
# GROUP 3 ALL OFF		              0x4A	           74
# GROUP 4 ALL ON		              0x4B	           75	(SYNC/PAIR RGB+W Bulb within 2 seconds of Wall Switch Power being turned ON)
# GROUP 4 ALL OFF		              0x4C	           76
#
# DISCO MODE	                    0x4D	           77
#
# SET COLOR TO WHITE (GROUP ALL)  0x42    100ms followed by:	0xC2
# SET COLOR TO WHITE (GROUP 1)    0x45	  100ms followed by:	0xC5
# SET COLOR TO WHITE (GROUP 2)    0x47	  100ms followed by:	0xC7
# SET COLOR TO WHITE (GROUP 3)    0x49	  100ms followed by:	0xC9
# SET COLOR TO WHITE (GROUP 4)    0x4B	  100ms followed by:	0xCB


require 'spec_helper'

describe LimitlessLed::Bridge do

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
      subject.send(:send_packet, "\x40\xFF\x55")

      # true.should be_true
      # subject.should_receive(:send_packet).with("\x40\xFF\x55")
    end
  end

  describe '#send_packet' do
    it 'should create a new socket and send the packet' do

      fake_socket = double(:fake_udp_socket)
      fake_socket.should_receive(:connect).with( subject.host, subject.port )
      fake_socket.should_receive(:send).with("\x40\xFF\x55", 0)

      UDPSocket.should_receive(:new) { fake_socket }

      subject.send(:send_packet, "\x40\xFF\x55")

    end

    it 'should raise an exception when improperly formed commands are sent' do
      # subject.send(:send_packet, "\x40\xFF\x55")
      # subject.should_receive(:new) { fake_socket }
    end
  end

end


