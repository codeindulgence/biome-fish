function _biome_enter --argument path
  set biome_name (basename $path)

  if [ -n "$_biome_prefix" ]
    set biome $_biome_prefix/$biome_name$_biome_filename
  else
    set biome $path/$_biome_filename
  end

  if [ -r $biome ]
    if [ (sha1sum $biome) != "$_biome_hash" ]

      echo Entering biome: $biome_name

      cat $biome | while read line
        if [ (string sub -s 1 -l 1 $line) = '#' ]
          continue
        end

        set line (string split -m 1 '=' -- $line)

        # Remove `export` statement if it is present
        set line (string replace 'export ' '' -- $line)

        set vname $line[1]
        set new_var $line[2]
        set old_var "$$vname"

        set -ga _biome_vnames "$vname"
        set -ga _biome_vars "$new_var"
        set -ga _biome_vars_old "$old_var"

        if [ "$new_var" = "$old_var" ]
          continue
        end

        # Set the actual variable!
        set -gx $vname $new_var

        if [ -n "$old_var" ]
          _red "- $vname: "(_biome_mask $vname $old_var)
        end

          _green "- $vname: "(_biome_mask $vname $new_var)
      end

      set -g _biome_loaded $path
      set -g _biome_name $biome_name
      set -g _biome_hash (sha1sum $biome)
    end
  end
end
