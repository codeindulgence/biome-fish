function biome -a direction path

  if [ -z $path ]
    set path $PWD
  end

  if test "$direction" = "enter"
    _biome_enter $path
  end


  if test "$direction" = "exit"
    _biome_exit
  end

end
