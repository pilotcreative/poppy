class Mpc
  
  @@regexps = {
    'ACK' => /\AACK \[(\d+)\@(\d+)\] \{(.?)\} (.+)\Z/,
    'OK'  => /\AOK\n\Z/,
  }
  def initialize(host = '127.0.0.1',port = 6600)
    @socket = TCPSocket.new(host,port)
    @socket.gets
  end
  
  def play(song = nil)
    song.nil? ? command = 'play' : command = "play #{song.to_i}"
    puts(command)
  end
  
  def pause
    puts('pause 1')
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
  
  def random(state=nil)
    if state.nil?
      random? ? random_state = 0 : random_state = 1
    else
      random_state = state
    end
    puts("random #{random_state}")
  end
  
  def random?
    status_hash = status
    status_hash[:random] == '1'
  end

  def repeat(state=nil)
    if state.nil?
      repeat? ? repeat_state = 0 : repeat_state = 1
    else
      repeat_state = state
    end
    puts("repeat #{repeat_state}")
  end
  
  def repeat?
    status_hash = status
    status_hash[:repeat] == '1'
  end
  
  def setvol(volume)
    begin
      unless (0..100).include?(volume)
        raise Exception.new("Volume should be between 0 (minimum) and 100 (maximum)")
      end
      puts("setvol #{volume.to_s}")
    end
  end

 def listall
  puts('listall')
 end
 
 def current_song
  to_hash(puts('currentsong'))
 end

 def stats
   to_hash(puts('stats'))
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
    to_hash(output)
  end

  def to_hash(string)
    status_hash = Hash.new
    string.each do |line|
      key, value = line.chomp.split(': ', 2) 
      status_hash[key.parameterize.underscore.to_sym] = value
    end 
    status_hash
  end

  class Exception < StandardError  
  end
end