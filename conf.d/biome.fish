function _biome --on-variable PWD
  if test -n "$_biome_loaded"
    switch $PWD
      case $_biome_loaded'*'
        biome enter

      case '*'
        biome exit

    end
  else
    if [ -r .biome ]
      biome enter $PWD
    end
  end
end
