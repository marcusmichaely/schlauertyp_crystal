require "yaml"

File.open(ARGV[0]) do |file|
  puts YAML.parse(file)[ARGV[1]].inspect
end
