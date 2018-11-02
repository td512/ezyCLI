puts "#{debug}Setting up listeners..."
listener = Listen.to(File.expand_path("~/.ezycli/plugins")) do |modified, added, removed|
  puts ""
  added.each do |ext|
    puts "#{info}Found new plugin! #{File.basename(ext, ".rb")}"
    puts "#{debug}Autoloading plugin #{File.basename(ext, ".rb")}"
    load_plugin File.basename(ext, ".rb")
  end
  modified.each do |ext|
    puts "#{info}Detected change in plugin #{File.basename(ext, ".rb")}"
    puts "#{debug}Autoreloading plugin #{File.basename(ext, ".rb")}"
    reload_plugin File.basename(ext, ".rb")
  end
  removed.each do |ext|
    puts "#{info}Detected removal of plugin #{File.basename(ext, ".rb")}"
    puts "#{debug}Autounloading plugin #{File.basename(ext, ".rb")}"
    unload_plugin File.basename(ext, ".rb")
  end

end
listener.start
