# REQUIREMENTS V1

* Find a workaround to StaticSaveConfig / Maybe GlobalConfig ?
>	StaticSaveConfig() will save the defaultproperties in xStats.ini at server startup. any changes made to xStats.ini
>	while the server is running will be overwritten by wathever value was declared at startup. Changes to the config file would
>	therefore only work if the server is turned off. ( workaround: Only call StaticSaveConfig() if xStats.ini is missing?)

* Increase performance of replication block; reliable / unreliable, stat variables, etc
  * Replication block conditionals
  * Variable replication
  * Usage of sleep()
  * Reduce new() / spawn()

* Thoroughly test mod:
  * Demo playback
  * General gameplay

# REQUIREMENTS V1+

* Implement default stats
  * Increase FlagAttacked / FlagDefended stat radius
  * Fix BB stat
  * ...
* Flag cap time stat
* Stop MA stats from being awarded when a groundhit splashes and kills a low HP target in the air.
> Need to override logic outside of ModeInfo. Perhaps more suited to a mutator like promod/tmod to avoid compatibility.
* Dynamic stat generation with stat template?
* ingame UI for client stat customisation (tvbp_b7 style)
