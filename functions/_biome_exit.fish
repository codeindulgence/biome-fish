function _biome_exit
  if not set -q _biome_loaded
    return
  end

  echo Exiting biome: (basename "$_biome_loaded")

  for i in (seq (count $_biome_vnames))
    set vname $_biome_vnames[$i]
    set old_var $_biome_vars_old[$i]
    set cur_var $_biome_vars[$i]

    if [ "$old_var" = "$cur_var" ]
      continue
    end

    _red "- $vname: "(_biome_mask $vname $cur_var)
    if [ -n $old_var ]
      set -gx $vname $old_var
      _green "- $vname: "(_biome_mask $vname $old_var)
    else
      set -e $vname
    end
  end

  set -e _biome_vars
  set -e _biome_vars_old
  set -e _biome_loaded
  set -e _biome_name
  set -e _biome_hash
  set -e _biome_vnames
end
