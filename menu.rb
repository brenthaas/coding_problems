class Menu

end


abort "usage: menu <filename> [item1 item2 ...]" unless filename = ARGV[0]

begin
  file = File.open(filename).foreach do |line|
  end
rescue
  abort "Error opening file: #{filename}"
end