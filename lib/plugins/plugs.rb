# WARNING: DO NOT MODIFY THIS FILE! I CANNOT BE MORE EXPLICIT!
# WARNING: THIS FILE LOADS THE RIGHT PLUG FOR THE LANGUAGE. *DO NOT TOUCH ME*!
def plug_exec(language, plugin_name)
  io = IO.popen("#{language} #{File.expand_path("~/.ezycli/plugs")}/php/#{plugin_name}.php")
  trap("INT") {
    puts "#{info}Ctrl-C received, cleaning up"
    Process.kill("INT", io.pid)
  }
  io.each do |line|
    if line.chomp.include? "Could not open input file"
      puts "#{error}Failed to run #{language} plug #{plugin_name}"
    else
      puts line.chomp
    end
  end
  trap('INT', 'DEFAULT')
end

def plug_loader(language, plugin_name)
  case
  when (language == "php")
    puts "#{warning}Plugs are limited to output only at this time"
    plug_exec("php", plugin_name)
  else
    puts "#{error}Couldn't find suitable plug language for #{language}"
  end
end

############ THESE FUNCTIONS MUST EXIST ############

def plugin_help
  return ["plug         - Executes a plug"]
end

def plugin_commands
  # I know, I know. I'll clean it up later. shhhhh
  return {"plug" => "plug_loader"}
end

def plugin_associations
  # see the above comment.
  return "plug" => ["plug"]
end

########### THESE FUNCTIONS MUST EXIST ############
