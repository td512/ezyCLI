# Yes, the ability to load plugins is itself a plugin. You may also not unload the plugin loader. This is a hardcoded dep for the application to run correctly

# Silence all warnings
def silence_warnings
    original_verbosity = $VERBOSE
    $VERBOSE = nil
    result = yield
    $VERBOSE = original_verbosity
    return result
end

def load_plugin(plugin_name)
  if @plugin_associations["plugin_name"]
    puts "#{error}Cowardly refusing to load a plugin that's already loaded"
  else
    begin
      silence_warnings {load "#{File.expand_path("~/.ezycli/plugins")}/"+plugin_name+".rb"}
      begin
        @plugin_help.push(plugin_help) unless @plugin_help.include? plugin_help
      rescue NameError => e
        # Do nothing if there's no such method
      end
      begin
        @plugin_commands.merge!(plugin_commands)
      rescue NameError => e
        # Do nothing if there's no such method
      end
      begin
        @plugin_associations.merge!(plugin_associations)
      rescue NameError => e
        # Do nothing if there's no such method
      end
      puts "#{info}Loaded plugin #{plugin_name}"
    rescue Exception => e
      puts "#{warning}Failed to load plugin #{plugin_name}"
    end
  end
end

############ THESE FUNCTIONS MUST EXIST ############

def plugin_help
  return ["load         - Loads a plugin"]
end

def plugin_commands
  # I know, I know. I'll clean it up later. shhhhh
  return {"load" => "load_plugin"}
end

def plugin_associations
  # see the above comment.
  return "load" => ["load"]
end

########### THESE FUNCTIONS MUST EXIST ############
