function _biome_exit
  if not set -q _biome_loaded
    return
  end

  echo Exiting biome: (basename "$_biome_loaded")

  for i in (seq (count $_biome_vnames))
    set vname $_biome_vnames[$i]
    set old_var $_biome_vars_old[$i]
    set cur_var $_biome_vars[$i]

    # Handle sensitive variables
    if _biome_is_secret $vname
      set secret true
      set cur_var (_biome_mask $cur_var)
    else
      set secret false
    end

    _red "- $vname: $cur_var"
    if [ -n $old_var ]
      set -gx $vname $old_var
      if $secret
        set old_var (_biome_mask $old_var)
      end
      _green "+ $vname: $old_var"
    else
      set -e $vname
    end
  end

  set -e _biome_vars
  set -e _biome_vars_old
  set -e _biome_loaded
  set -e _biome_name
  set -e _biome_hash
end
