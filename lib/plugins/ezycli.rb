require "readline"

# What? you thought that the CLI also wouldn't be a plugin?
def cli_is_ready
  puts "#{info}Loaded #{@plugin_counter} plugin(s)!"
  puts "#{info}Welcome to the ezyCLI! _stuck? try 'help'"
end

def cli_loop
  loop {
      begin
        input = Readline.readline("ezyCLI> ", true)
        if input.instance_of? String
          cli_cmd(input)
        else
          exit 0
        end
        rescue SystemExit, Interrupt => e
          exit 0
      end
  }
end

def cli_cmd(cmd)
  begin
    case
    when (cmd.include?("help"))
      puts "help         - Provides this help text"
      puts "version      - Shows the version of ezyCLI"
      puts "exit         - Exits ezyCLI"
      puts @plugin_help
    when (cmd.include?("exit"))
      @newline = 0
      exit 0
    when (cmd.include?("version"))
      puts "ezyCLI version 0.2.3 DEV"
    when (cmd.empty?)
      # blank command...
    else
      c = cmd.split(" ")
      if c.count == 1
      begin
        send(@plugin_commands["#{cmd}"])
      rescue ArgumentError => e
        puts "#{warning}Wrong number of arguments given"
      rescue TypeError => e
        puts "#{warning}Unknown command: #{cmd}"
      end
      else
        args = Array.new
        begin
        c[1..-1].each do |arg|
          args.push(arg)
        end
        send(@plugin_commands["#{c[0]}"], *args)
      rescue ArgumentError => e
        puts "#{warning}Wrong number of arguments given"
      rescue TypeError => e
        puts "#{warning}Unknown command: #{cmd}"
      end
      end
    end
  rescue NoMethodError => e
    # Nothing doing
  end
end
