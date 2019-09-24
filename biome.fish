function _biome_color
  set color $argv[1]
  set string $argv[2]
  echo (set_color $color)$string(set_color normal)
end
function _green; _biome_color green "$argv"; end
function _red;   _biome_color red   "$argv"; end

function _mask
  echo '********'(string sub -s -4 $argv)
end

function _secret
  string match -iqr '.*key|pass|secret.*' $argv
end

function biome

  if test "$argv[1]" = "enter"
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
          set -gx $vname $new_var

          # Handle sensitive variables
          if _secret $vname
            set secret true
            set new_var (_mask $new_var)
          else
            set secret false
          end

          if [ -n "$old_var" ]
            if $secret
              set old_var (_mask $old_var)
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


  if test "$argv" = "exit"
    if not set -q _biome_loaded
      return
    end

    echo Exiting biome: (basename "$_biome_loaded")

    for i in (seq (count $_biome_vnames))
      set vname $_biome_vnames[$i]
      set old_var $_biome_vars_old[$i]
      set cur_var $_biome_vars[$i]

      # Handle sensitive variables
      if _secret $vname
        set secret true
        set cur_var (_mask $cur_var)
      else
        set secret false
      end

      _red "- $vname: $cur_var"
      if [ -n $old_var ]
        set -gx $vname $old_var
        if $secret
          set old_var (_mask $old_var)
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
end
