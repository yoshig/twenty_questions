require 'yaml'


# x = ["First Q", ["Is it a dog?", true, false], false].to_yaml

#     File.open("test.txt", "w") do |f|
#       f.puts x.to_yaml
#     end

y = YAML::load(File.read(
      ARGV.empty? ? 'test.txt' : ARGV[0]))
p y