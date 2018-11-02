#!/bin/env ruby

@plugin_counter = 0
@plugin_array = Array.new
@plugin_help = Array.new
@plugin_commands = Hash.new
@plugin_associations = Hash.new
# The plugins you are not allowed to unload or reload. To reload these, you need to restart the application.
REQUIRED_PLUGINS = ["load", "unload", "ezycli"]
# Freeze the array, no other plugins should be immutable
REQUIRED_PLUGINS.freeze
