class Mpc
  
  def initialize(host = '127.0.0.1',port = 6600)
    @random = 0
    @pause  = 0
    @repeat = 0
    #begin
    socket = TCPSocket.new(host,port)
    @output = @socket.gets
    #rescue 
    ##TODO: rescue
    #end    
    @output
  end
  
  def play(song = nil)
    song.nil? ? command = 'play' : command = "play #{song.to_i}"
    send_command(command)
  end
  
  def pause
    @pause==0 ? @pause = 1 : @pause = 0
    send_command("pause #{@pause}")
  end
  
  def pause?
    @pause==1
  end
  
  def pause!
    @pause = 0
    self.pause
  end
  
  def stop
    send_command('stop')
  end
  
  def next
    send_command('next')
  end
  
  def previous
    send_command('previous')
  end
  
  def random
    @random==0 ? @random = 1 : @random = 0
    send_command("random #{@random}")
  end
  
  def random?
    @random == 1
  end
  
  def random!
    @random = 0
    self.random
  end
  
  def repeat
    @repeat==0 ? @repeat = 1 : @repeat = 0
    send_command("repeat #{@repeat}")
  end
  
  def repeat?
    @repeat == 1
  end
  
  def repeat!
    @repeat = 0
    self.repeat
  end
  
  
  def setvol(volume)
    unless (0..100).include?(volume)
      raise "Volume should be between 0 (minimum) and 100 (maximum)"
    end
    send_command("setvol #{volume}")
    @socket.gets
  end
 
  private
  
  def send_command command
    @socket.puts(command)
    output = @socket.gets
    
  end

end