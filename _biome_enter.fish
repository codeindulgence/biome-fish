function _biome_enter -a path
  set biome $path/$_biome_filename
  if [ -r $biome ]
    if [ (sha1sum $biome) != "$_biome_hash" ]

      echo Entering biome: (basename $path)

      cat $biome | while read line
        set line (string split '=' $line)

        # Remove `export` statement if it is present
        set line (string replace 'export ' '' $line)

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

        # Handle sensitive variables
        if _biome_is_secret $vname
          set secret true
          set new_var (_biome_mask $new_var)
        else
          set secret false
        end

        if [ -n "$old_var" ]
          if $secret
            set old_var (_biome_mask $old_var)
          end
          _red "- $vname: $old_var"
        end

        _green "+ $vname: $new_var"
      end

      set -g _biome_loaded $path
      set -g _biome_name (basename $path)
      set -g _biome_hash (sha1sum $biome)
    end
  end
end
