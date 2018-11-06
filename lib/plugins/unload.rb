# Yes, the ability to unload plugins is itself a plugin. You may also not unload the plugin unloader. This is a hardcoded dep for the application to run correctly

def unload_plugin(plugin_name)
  if REQUIRED_PLUGINS.include? plugin_name
    puts "#{error}Cowardly refusing to unload a core plugin"
  else
    begin
      @plugin_associations["#{plugin_name}"].each do |ext|
        @plugin_commands.delete("#{ext}")
        @plugin_help.reject! {|e| e == ext}
      end
      @plugin_associations.delete("#{plugin_name}")
      puts "#{info}Unloaded plugin #{plugin_name}"
    rescue Exception => e
      puts "#{warning}Failed to unload plugin #{plugin_name}"
    end
  end
end

############ THESE FUNCTIONS MUST EXIST ############

def plugin_help
  return ["unload       - Unloads a plugin"]
end

def plugin_commands
  # I know, I know. I'll clean it up later. shhhhh
  return {"unload" => "unload_plugin"}
end

def plugin_associations
  # see the above comment.
  return "unload" => ["unload"]
end

########### THESE FUNCTIONS MUST EXIST ############
