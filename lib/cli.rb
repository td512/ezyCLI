#!/usr/bin/env ruby

# SETUP # DO NOT REMOVE ME # THIS SETS UP THE CORRECT COLORS AND LAYOUTS FOR THE APPLICATION
# Require the variables that make this application run.
require("#{File.expand_path(File.dirname(__FILE__))}/vars.rb")
require 'listen'
require 'active_support'
require 'active_support/core_ext'
require 'fileutils'

# COLORS!
def colorize(text, color = "default", bgColor = "default")
    colors = {"default" => "38","black" => "30","red" => "31","green" => "32","brown" => "33", "blue" => "34", "purple" => "35",
     "cyan" => "36", "gray" => "37", "dark gray" => "1;30", "light red" => "1;31", "light green" => "1;32", "yellow" => "1;33",
      "light blue" => "1;34", "light purple" => "1;35", "light cyan" => "1;36", "white" => "1;37"}
    bgColors = {"default" => "0", "black" => "40", "red" => "41", "green" => "42", "brown" => "43", "blue" => "44",
     "purple" => "45", "cyan" => "46", "gray" => "47", "dark gray" => "100", "light red" => "101", "light green" => "102",
     "yellow" => "103", "light blue" => "104", "light purple" => "105", "light cyan" => "106", "white" => "107"}
    color_code = colors[color]
    bgColor_code = bgColors[bgColor]
    return "\033[#{bgColor_code};#{color_code}m#{text}\033[0m"
end

# Color mappings
def info
  return colorize("[INFO] ", "green")
end
def warning
  return colorize("[WARNING] ", "yellow")
end
def error
  return colorize("[ERROR] ", "red")
end
def debug
  return colorize("[DEBUG] ", "blue")
end

def exit_handler
  if !@newline
    puts ""
  end
  begin
    save_history
  rescue NoMethodError => e
    puts "#{error}Unable to save history!"
  end
  puts "#{debug}Exiting ezyCLI"
  puts "#{info}Have a great day!"
end

# END APPLICATION SETUP BLOCK #

# Start by first loading all known plugins. This reads the plugin from disk.
# TODO: Extend to allow plugin dependencies, i.e. load the plugins this one requires before loading this one.
unless File.directory?(File.expand_path("~/.ezycli/plugins"))
  puts "#{info}Creating plugin directory"
  FileUtils.mkdir_p(File.expand_path("~/.ezycli/plugins"))
end
unless File.directory?(File.expand_path("~/.ezycli/plugs/php"))
  puts "#{info}Creating plugs directory"
  FileUtils.mkdir_p(File.expand_path("~/.ezycli/plugs/php"))
end
def application_start
  Dir["#{File.expand_path(File.dirname(__FILE__))}/plugins/*.rb"].sort.each do |file|
      puts "#{debug}Loading application plugin #{File.basename(file, ".rb")}"
    require file
    @plugin_counter += 1
    @plugin_array.push(File.basename(file))
    begin
      @plugin_help.push(plugin_help) unless @plugin_help.include? plugin_help
    rescue NameError => e
      # Do nothing if there's no such method
    end
    begin
      @plugin_commands.merge!(plugin_commands)
    rescue NameError => e
      # Do nothing if theunlessre's no such method
    end
    begin
      @plugin_associations.merge!(plugin_associations)
    rescue NameError => e
      # Do nothing if there's no such method
    end
  end
  begin
    load_history
  rescue NoMethodError => e
    puts "#{error}Unable to load history!"
  end
  puts "#{info}Attempting to load user plugins from #{File.expand_path(File.dirname("~/.ezycli/plugins"))}"
  Dir["#{File.expand_path("~/.ezycli/plugins")}/*.rb"].sort.each do |file|
      puts "#{debug}Loading user plugin #{File.basename(file, ".rb")}"
    require file
    @plugin_counter += 1
    @plugin_array.push(File.basename(file))
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
  end
  File.open("#{File.expand_path("~/.ezycli/plugs/php")}/hello-world.php", 'w') { |file| file.write("<?php \necho 'Hello, World!';\n") } unless File.file? "#{File.expand_path("~/.ezycli/plugs/php")}/hello-world.php"
  File.open("#{File.expand_path("~/.ezycli/plugins")}/test.rb", 'w') { |file| file.write("def test_function\nputs 'This is a test plugin that was automatically generated when you first ran ezyCLI'\nend\n\n############ THESE FUNCTIONS MUST EXIST ############\n\ndef plugin_commands\n# This is where you tell ezyCLI about the plugins it's to use\nreturn {\"testme\" => \"test_function\"}\nend\n\ndef plugin_associations\n# This is where you tell ezyCLI about which plugins belong to which file. I'll eventually fix that.\nreturn \"test\" => [\"testme\"]\nend") } unless File.file? "#{File.expand_path("~/.ezycli/plugins")}/test.rb"
  end

# Set the exit handler
at_exit {exit_handler}

# Boot the CLI and let the user know it's now ready to be used.
application_start
cli_is_ready
cli_loop
