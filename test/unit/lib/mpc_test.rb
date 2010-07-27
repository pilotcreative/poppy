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
    @mpc.stubs(:gets).returns("directory: Abra Dab\ndirectory: Abra Dab/Miasto Jest Nasze\nfile: Abra Dab/Miasto Jest Nasze/ABRADAB - Bezposrednio.mp3\n")
    assert_equal("directory: Abra Dab\ndirectory: Abra Dab/Miasto Jest Nasze\nfile: Abra Dab/Miasto Jest Nasze/ABRADAB - Bezposrednio.mp3\n",@mpc.listall )
  end
  
  test "status outputs propper hash" do
    @mpc.stubs(:gets).returns("volume: -1\nrepeat: 0\nrandom: 0\nsingle: 0\nconsume: 0\nplaylist: 43\nplaylistlength: 41\nxfade: 0\nstate: stop\nsong: 17\nsongid: 17\nnextsong: 18\nnextsongid: 18\n")
    assert_equal({:songid=>"17", :state=>"stop", :single=>"0", :volume=>"-1", :nextsong=>"18", :consume=>"0", :nextsongid=>"18", :playlist=>"43", :repeat=>"0", :song=>"17", :playlistlength=>"41", :random=>"0", :xfade=>"0"},@mpc.send(:status) )
  end

  test "random without state should send request with opposite value" do
    @mpc.stubs(:status).returns({:songid=>"17", :state=>"stop", :single=>"0", :volume=>"-1", :nextsong=>"18", :consume=>"0", :nextsongid=>"18", :playlist=>"43", :repeat=>"0", :song=>"17", :playlistlength=>"41", :random=>"0", :xfade=>"0"})
    @mpc.expects(:puts).with('random 1')
    @mpc.random
  end

  test "random with state should send request with given value" do
    @mpc.stubs(:status).returns({:songid=>"17", :state=>"stop", :single=>"0", :volume=>"-1", :nextsong=>"18", :consume=>"0", :nextsongid=>"18", :playlist=>"43", :repeat=>"0", :song=>"17", :playlistlength=>"41", :random=>"0", :xfade=>"0"})
    @mpc.expects(:puts).with('random 0')
    @mpc.random(0)
  end

  test "repeat without state should send request with opposite value" do
    @mpc.stubs(:status).returns({:songid=>"17", :state=>"stop", :single=>"0", :volume=>"-1", :nextsong=>"18", :consume=>"0", :nextsongid=>"18", :playlist=>"43", :repeat=>"0", :song=>"17", :playlistlength=>"41", :random=>"0", :xfade=>"0"})
    @mpc.expects(:puts).with('repeat 1')
    @mpc.repeat
  end

  test "repeat with state should send request with given value" do
    @mpc.stubs(:status).returns({:songid=>"17", :state=>"stop", :single=>"0", :volume=>"-1", :nextsong=>"18", :consume=>"0", :nextsongid=>"18", :playlist=>"43", :repeat=>"0", :song=>"17", :playlistlength=>"41", :random=>"0", :xfade=>"0"})
    @mpc.expects(:puts).with('repeat 0')
    @mpc.repeat(0)
  end

  test "setvol with volume in propper range should not raise exception" do
    @mpc.expects(:puts).with('setvol 100')
    @mpc.setvol(100)
  end

  test "setvol with volume out of range should raise exception" do
    assert_raise(Mpc::Exception) do
      @mpc.setvol(200)
    end
  end
end