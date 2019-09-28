function _biome_list
  if [ -n "$_biome_loaded" ]
    echo In biome (_green $_biome_name)

    cat $_biome_loaded/$_biome_filename | while read line
      if [ (string sub -s 1 -l 1 $line) = '#' ]
        continue
      end

      set line (string split '=' $line)
      echo -n '  '
      echo "$line[1]: "(_biome_mask $line)
    end
  end
end
