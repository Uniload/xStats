# xStats
> Tribes ReVengeance gameplay mutator. Latest version xStats_b1


Features:
* Client-sided stat message customisation (Both for ingame and during demo playback)
* Server-Sided stat configuration:
  * Individually configurable stat settings.
  * Dynamic stat loading to avoid compatibility issues.
* new distance stat.


## Installation

* Clients & Demo playback:

  1. Copy `xStats.u` to your `Program/Bin/` directory. (A cached copy of the mutator will work as well).
  2. Edit the automatically generated `xStats.ini` file to your liking.


* Server (NM_DedicatedServer & NM_ListenServer):

  1. Copy `xStats.u` to your `Program/Bin/` directory.
  2. Add `ServerPackages=xStats`to your `Beta_Dedivated_Server.ini` file, under `[Engine.GameEngine]`.
  (_Failing to perform this step will make the server shutdown the first time it is called with the xStat mutator parameter. This is because the mod has been added to the ServerPackages automatically, but it will only take effect after a server restart._)
  
  3. Run your server with the following mutator parameter: `?mutator=xStats.main`.
  
  4. If you are running x2 or promod, make sure set `BonusStatsOn=False` in their respective config files. 
  
  5. If you have a mutator running that modifies the custom ProjectileDamageTypes (f.e. promod), you will have to edit the automatically generated `xStats.ini` file to refer to the modified ProjectileDamageTypes. 


## xStats.ini example

The config file will automatically be generated if missing, or load the variables at every Level startup.

Please refer to **[xStats.ini][configfile]** for an overview of the config file.


## Package Compilation

```sh
ucc.exe make -nobind
ucc.exe editor.stripsourcecommandlet xStats.u
```


## Release History

* xStats_b1
    * Work in progress

<!-- Markdown link & img dfn's -->
[configfile]: https://github.com/Uniload/xStats/blob/master/xStats.ini
