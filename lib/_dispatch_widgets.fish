#!/usr/bin/env fish
set os (uname)
if [ $os = "Darwin" ]
	set -g icons 🚏 ⏱ 🚄 💨
else 
	set -g icons    
end

for file in ./widgets.d/**/*.fish
    source $file
end
