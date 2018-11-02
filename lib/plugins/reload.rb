# Silence all warnings
def silence_warnings
    original_verbosity = $VERBOSE
    $VERBOSE = nil
    result = yield
    $VERBOSE = original_verbosity
    return result
end

def reload_plugin(plugin_name)
  unload_plugin plugin_name
  load_plugin plugin_name
end

############ THESE FUNCTIONS MUST EXIST ############

def plugin_help
  return ["reload       - Reloads a plugin"]
end

def plugin_commands
  # I know, I know. I'll clean it up later. shhhhh
  return {"reload" => "reload_plugin"}
end

def plugin_associations
  # see the above comment.
  return "reload" => ["reload"]
end

########### THESE FUNCTIONS MUST EXIST ############
