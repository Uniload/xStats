# REQUIREMENTS V1
  
### Beta_v2

* Auto generate StatSettings config file
> Find a workaround to StaticSaveConfig / Maybe GlobalConfig.
>	StaticSaveConfig() will save the defaultproperties in xStats.ini at server startup. any changes made to xStats.ini
>	while the server is running will be overwritten by wathever value was declared at startup. Changes to the config file would
>	therefore only work if the server is turned off. ( workaround: Only call StaticSaveConfig() if xStats.ini is missing?) 

* Increase performance of replication block; reliable / unreliable, stat variables, etc
  * PostNetBeginPlay
  * Replication block conditionals
  * Variable replication
  * Usage of sleep()
  * Reduce new() / spawn()

* Thoroughly test mod:
  * Demo playback
  * General gameplay

# REQUIREMENTS V1+

* FIX ENDGAME STATS
* Implement teamkill / friendlyfire target message
* Implement/fix default stats
  * Increase FlagAttacked / FlagDefended stat radius
  * Fix BB stat
  * ...
* Flag cap time stat
* Dynamic stat generation with stat template?
* ingame UI for client stat customisation (tvbp_b7 style)
* award stats when they occur after being killed?
