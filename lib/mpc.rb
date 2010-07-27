class Mpc
  
  @@regexps = {
    'ACK' => /\AACK \[(\d+)\@(\d+)\] \{(.?)\} (.+)\Z/,
    'OK'  => /\AOK\n\Z/,
  }
  def initialize(host = '127.0.0.1',port = 6600)
    @socket = TCPSocket.new(host,port)
    gets
  end
  
  def play(song = nil)
    song.nil? ? command = 'play' : command = "play #{song.to_i}"
    puts(command)
  end
  
  def pause
    puts('pause')
  end
  
  def paused?
    status_hash = status
    status_hash[:state] == 'pause'
  end
  
  def stop
    puts('stop')
  end
  
  def next
    puts('next')
  end
  
  def previous
    puts('previous')
  end
  
  #not implemented yet
  def random
  end
  
  #not implemented yet
  def random?
  end

  #not implemented yet
  def repeat
  end
  
  #not implemented yet
  def repeat?
  end
  
  def setvol(volume)
    unless (0..100).include?(volume)
      raise Exception("Volume should be between 0 (minimum) and 100 (maximum)")
    end
    puts("setvol #{volume}")
  end
 
 
 def listall
  puts('listall')
 end
 
  private
  
  def puts(command)
    @socket.puts(command)
    gets
  end
  

  def gets
    response = ""
    while line = @socket.gets do
      if @@regexps['OK'].match(line)
        return response
      elsif error = @@regexps['ACK'].match(line)
        raise Exception
      else
        response << line
      end
    end
    response
  end
  
  def status
    output = puts('status')
    status_hash = Hash.new
    output.each do |line| 
      key, value = line.chomp.split(': ', 2) 
      status_hash[key.parameterize.underscore.to_sym] = value
    end 
    status_hash
  end

  class Exception < StandardError  
  end
end