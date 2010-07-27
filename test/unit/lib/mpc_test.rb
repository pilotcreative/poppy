require "test_helper"
class MpcTest < Test::Unit::TestCase
  
  def setup
    @mpc = Mpc.new
    TCPSocket.any_instance.stubs(:puts).returns(nil)
  end
  
  test "gets raises an exception on ACK response" do
    TCPSocket.any_instance.stubs(:gets).returns("ACK [5@0] {} unknown command \"asd\"\n")
    assert_raise(Mpc::Exception) do 
      @mpc.send(:puts,'asd')
    end
  end
  
  test "gets outputs empty string on OK response " do
    TCPSocket.any_instance.stubs(:gets).returns("OK\n")
    assert_equal("",@mpc.stop )
  end
  
  test "gets outputs hash on  listall command" do
    TCPSocket.any_instance.stubs(:gets).returns("directory: Abra Dab\n","directory: Abra Dab/Miasto Jest Nasze\n","file: Abra Dab/Miasto Jest Nasze/ABRADAB - Bezposrednio.mp3\n","OK\n")
    assert_equal("directory: Abra Dab\ndirectory: Abra Dab/Miasto Jest Nasze\nfile: Abra Dab/Miasto Jest Nasze/ABRADAB - Bezposrednio.mp3\n",@mpc.listall )
  end
  
  test "status outputs propper hash" do
    TCPSocket.any_instance.stubs(:gets).returns("volume: -1\n","repeat: 0\n","random: 0\n","single: 0\n","consume: 0\n","playlist: 43\n","playlistlength: 41\n","xfade: 0\n","state: stop\n","song: 17\n","songid: 17\n","nextsong: 18\n","nextsongid: 18\n","OK\n")
    assert_equal({:songid=>"17", :state=>"stop", :single=>"0", :volume=>"-1", :nextsong=>"18", :consume=>"0", :nextsongid=>"18", :playlist=>"43", :repeat=>"0", :song=>"17", :playlistlength=>"41", :random=>"0", :xfade=>"0"},@mpc.send(:status) )
  end
end