if not set -q _biome_auto; set -g _biome_auto true; end
if not set -q _biome_mask_char; set -g _biome_mask_char '*'; end
if not set -q _biome_filename; set -g _biome_filename '.biome'; end

function _biome --on-event fish_prompt

  if not $_biome_auto
    return
  end

  # If PWD is not the current biome or a subdirectory of it, then exit biome
  if not string match -qr "^$_biome_loaded" "$PWD"
    biome exit
  end

  set path $PWD

  # Recursively search parent folders
  while [ "$path" != '/' ]
    if [ -r $path/$_biome_filename ]
      biome enter $path
      break
    else
      set path (realpath "$path/..")
    end
  end
end

function _biome_color
  set color $argv[1]
  set string $argv[2]
  echo (set_color $color)$string(set_color normal)
end

function _green; _biome_color green "$argv"; end
function _red;   _biome_color red   "$argv"; end

function _biome_is_secret
  string match -iqr '.*key|pass|secret.*' $argv
end

function _biome_mask
  set length (string length "$argv")
  set reveal_length 4

  if [ $length -le $reveal_length ]
    echo (string repeat -n $length $_biome_mask_char)
    return
  end

  set mask_length (math $length - $reveal_length)
  if [ $mask_length -lt $reveal_length ]
    set mask_length $reveal_length
    set reveal_length (math $length - $mask_length)
  end
  set masked_string (string repeat -n $mask_length $_biome_mask_char)
  set reveal_string (string sub -s -$reveal_length $argv)
  echo $masked_string$reveal_string
end
