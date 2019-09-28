function _biome_list
  if [ -n "$_biome_loaded" ]
    echo In biome (_green $_biome_name)

    cat $_biome_loaded/$_biome_filename | while read line
      echo -n '  '
      string replace = ': ' $line
    end
  end
end
