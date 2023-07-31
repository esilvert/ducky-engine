require 'ducky/ducky.rb'

def tick(args)
  $ducky ||= Ducky.configure

  $ducky.tick(args)
end
