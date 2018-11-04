Gem::Specification.new do |s|
  s.name        = 'ezycli'
  s.version     = '0.2.2'
  s.date        = '2018-11-04'
  s.summary     = "The ezy way to manage your workspace"
  s.description = "The ezy way to manage your workspace"
  s.authors     = ["Theo Morra"]
  s.email       = 'theo@theom.nz'
  s.files       = ["lib/cli.rb", "lib/plugins", "lib/plugins/plugs.rb", "lib/plugins/history.rb", "lib/plugins/unload.rb", "lib/plugins/reload.rb", "lib/plugins/load.rb", "lib/plugins/ezycli.rb", "lib/plugins/zlisten.rb", "lib/plugs", "lib/plugs/php", "lib/plugs/php/hello-world.php", "lib/vars.rb", "bin/ezycli"]
  s.add_runtime_dependency 'listen', '~> 3.1.5'
  s.add_runtime_dependency 'activesupport', '5.2.1'
  s.add_runtime_dependency 'readline'
  s.homepage    =
    'http://rubygems.org/gems/ezycli'
  s.license       = 'GPL-3.0-or-later'
end
