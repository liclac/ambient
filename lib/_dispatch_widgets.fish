#!/usr/bin/env fish

for file in ./widgets.d/**/*.fish
    source $file
end
