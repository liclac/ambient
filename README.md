ambient
========

This is a script which captures ambient information available on certain public networks, such as the route, speed and delay information available on:
- German ICE trains
- Eurostar
- Austrian RailJet trains

If you spot a network with some tidbits of information available, please open a PR to add it!

Requirements
------------

The set of dependencies is intentionally kept small:

- `fish` (the shell)
- `iw` (to check what network you're on)
- `jq`
- The POSIX standard tools, such as `grep` and `sed`

Usage
-----

If you just run `ambient` on its own, it'll output all the data it can find in `KEY=VALUE` format, such that it can be given to `env`.

As a convenience, running eg. `ambient myscript.py` will run the given command with all of this data in the environment.

Example output (abbreviated):

```
$ ./ambient
AMBIENT_DE_ICE_SPEED=158
AMBIENT_DE_ICE_SPEED_UNIT=km/h
AMBIENT_DE_ICE_TZN=Tz4652
AMBIENT_DE_ICE_SERIES=406
AMBIENT_DE_ICE_WAGON_CLASS=SECOND
AMBIENT_DE_ICE_TRAIN_TYPE=ICE
AMBIENT_DE_ICE_TRIP_DATE=2020-01-02
AMBIENT_DE_ICE_VZN=14
AMBIENT_DE_ICE_STOP_FIRST=Frankfurt (Main) Hbf
AMBIENT_DE_ICE_STOP_FIRST_DEPART_SCHEDULED=2020-01-02T13:29:00Z
AMBIENT_DE_ICE_STOP_FIRST_DEPART_ACTUAL=2020-01-02T13:54:00Z
AMBIENT_DE_ICE_STOP_FIRST_DEPART_DELAY=+25
AMBIENT_DE_ICE_STOP_LAST=Bruxelles Midi
AMBIENT_DE_ICE_STOP_LAST_ARRIVE_SCHEDULED=2020-01-02T16:35:00Z
AMBIENT_DE_ICE_STOP_LAST_ARRIVE_ACTUAL=2020-01-02T17:32:00Z
AMBIENT_DE_ICE_STOP_LAST_ARRIVE_DELAY=+57
AMBIENT_DE_ICE_STOP_NEXT=Bruxelles-Nord
AMBIENT_DE_ICE_STOP_NEXT_DEPART_SCHEDULED=2020-01-02T16:28:00Z
AMBIENT_DE_ICE_STOP_NEXT_DEPART_ACTUAL=2020-01-02T17:25:00Z
AMBIENT_DE_ICE_STOP_NEXT_DEPART_DELAY=+57
AMBIENT_DE_ICE_STOP_NEXT_ARRIVE_SCHEDULED=2020-01-02T16:26:00Z
AMBIENT_DE_ICE_STOP_NEXT_ARRIVE_ACTUAL=2020-01-02T17:23:00Z
AMBIENT_DE_ICE_STOP_NEXT_ARRIVE_DELAY=+57
```

Running `ambient-widgets` will run the built-in widget scripts (WIP, uses Font Awesome):

```
$ ./ambient-widgets
 Bruxelles-Nord
 ICE-14
 219 km/h
```

Status bar usage
----------------

Do you want to see how late your current train is, from the comfort of your status bar? Look no further!

### awesomewm (+ vicious)

Create a custom widget which calls the widget script, and replace all newlines with spaces.

```
myambien = wibox.widget.textbox()
vicious.register(myambien, function(format, warg)
    local f = io.popen("echo -n ' '; " .. os.getenv("HOME") .. "/Projects/src/github.com/liclac/ambient/ambient-widgets")
    local out = f:read("*all")
    f:close()
    return { out:gsub('\n', ' ') }
end, "$1", 31)
```

Remember to add it to your `wibox` list! Search for `mytextclock` with a default configuration.

Why `fish`? Why not `bash` or `zsh`?
------------------------------------

First of all, this was written on a horribly delayed ICE train, and I happen to use `fish` as my daily driver.

Second, it's quite fast and has a number of nice features like lazy-loaded functions, and semantics that make it harder to shoot yourself in the foot.

If people want it migrated to `bash` or `zsh`, that's totally doable.
