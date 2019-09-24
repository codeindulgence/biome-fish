function _biome_enter
  if [ -r .biome ]
    if [ (sha1sum .biome) != "$_biome_hash" ]
      # Get the list of vars we're about to load
      set -g _biome_vnames (sed -n 's/^export \([A-z0-9_-]*\)=.*/\1/p' .biome)
      set -g _biome_vars   (sed -n 's/^export [A-z0-9_-]*=\(.*\)/\1/p' .biome)

      # Now load .biome
      echo Entering biome: (basename $PWD)

      # Save the old values if they exist
      for i in (seq (count $_biome_vnames))
        set vname $_biome_vnames[$i]
        set old_var "$$vname"
        set new_var $_biome_vars[$i]

        set -g _biome_vars_old $_biome_vars_old "$old_var"

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

      set -g _biome_loaded $PWD
      set -g _biome_name (basename $PWD)
      set -g _biome_hash (sha1sum .biome)
    end
  end
end
