#!/usr/bin/env fish

if test (uname) = "Darwin"
	set -g icons 🚏 ⏱ 🚄 💨
else 
	set -g icons    
end

for file in ./widgets.d/**/*.fish
    source $file
end
