require "test_helper"
class MpcTest < Test::Unit::TestCase
  
  setup do 
    @mpc = Mpc.new
  end
  test "send_command raises an error on ACK message" do
    assert_raise(MPC::ArgumentError) do 
      @mpc.send(:send_command,'asddsa')
    end
  end
end