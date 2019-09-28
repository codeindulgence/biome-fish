function biome -a command path

  if [ -z "$path" ]
    set path $PWD
  end

  if [ -z  "$command" ]
    set command list
  end

  set func "_biome_$command"

  if type -q $func;
    $func $path
  else
    echo Unknown command: $command
  end

end
