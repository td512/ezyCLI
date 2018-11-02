require 'yaml'

def save_history
  File.open("#{File.expand_path("~/.ezycli")}/.ezycli_history", 'w') { |f| f.write(YAML.dump(Readline::HISTORY.to_a))}
  puts "#{info}Wrote history to #{File.expand_path("~/.ezycli")}/.ezycli_history"
end

def load_history
  if File.file?("#{File.expand_path("~/.ezycli")}/.ezycli_history")
    conf = YAML.load_file "#{File.expand_path("~/.ezycli")}/.ezycli_history"
    conf.each do |line|
      if line.present? and !line.include? "exit"
        Readline::HISTORY.push(line)
      end
    end
  else
    puts "#{info}Initialized empty history"
  end
end

############ THESE FUNCTIONS MUST EXIST ############

def plugin_commands
  # I know, I know. I'll clean it up later. shhhhh
  return {"save" => "save_history", "reset" => "load_history"}
end

def plugin_associations
  # see the above comment.
  return "history" => ["save", "reset"]
end

########### THESE FUNCTIONS MUST EXIST ############
