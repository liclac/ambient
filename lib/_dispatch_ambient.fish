#!/usr/bin/env fish

# Make fish autoload our functions before trying built-in ones.
set -p fish_function_path ./functions.d

for file in ./ambient.d/**/*.fish
    source $file
end
