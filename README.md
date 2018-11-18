# xStats
> Tribes ReVengeance gameplay mutator. Latest version xStats_b1


Features:
* Client-sided stat message customisation (Both for ingame and during demo playback)
* Server-Sided stat configuration:
  * Individually configurable stat settings.
  * Dynamic stat loading to avoid compatibility issues.
* new general distance stat.
* new disc distance stat.
* new snipe distance stat.
* added a cap to max sustained speed stat
* ...

Extra:
* Distance values are converted to what I believe are meters (could be yards?) (same conversion as distance to flag seen on radar)
  * vectorToMeter(Vector v, out float distanceInMeters) {distanceInMeters = v * 0.0125}
  * *vectorToMeter(4000) = 50m*
  * *vectorToMeter(8000) = 100m*

***
## Installation

* Clients & Demo playback:

  1. Copy `xStats.u` to your `Program/Bin/` directory. (A cached copy of the mutator will work as well).
  2. Edit the automatically generated `xStats.ini` file to your liking.

* Server (NM_DedicatedServer & NM_ListenServer):

  1. Copy `xStats.u` to your `Program/Bin/` directory.
  2. Add `ServerPackages=xStats_b1`to your `Beta_Dedivated_Server.ini` file, under `[Engine.GameEngine]`.
  (_Failing to perform this step will make the server shutdown the first time it is called with the xStat mutator parameter. This is because the mod has been added to the ServerPackages automatically, but it will only take effect after a server restart._)
   3. If you are running x2 or promod, make sure to set `BonusStatsOn=False` in their respective config files.

   4. If you have a mutator running that modifies the default ProjectileDamageTypes (f.e. promod), you will have to edit the automatically generated `xStats.ini` file to refer to the modified ProjectileDamageTypes like so:
  ```ini
  stat_HS_PDT=Class'promod_v1rc7_b3.promodSniperProjectileDamageType'
  stat_EBMA_PDT=Class'promod_v1rc7_b3.promodBladeProjectileDamageType'
  ```
   5. Run your server with the following mutator parameter: `?mutator=xStats_b3.main`.


***
## xStats.ini example

The config file will automatically be generated if missing, or load the variables at every Level startup.

Please refer to the **[Client xStats.ini][Client_configfile]** and **[Server xStats.ini][Server_configfile]** for an overview of the config file.

***
## Package Compilation

UCC.ini file:
###### NOTE: xStats holds references to the default `StatClasses.pkg` package. Since there is no way to obtain the sourcecode of StatsClasses, you will have to create a stub `StatClasses.u` package for xStats to compile successfuly.</dd>
```ini
[Editor.EditorEngine]
...
EditPackages=StatClasses
EditPackages=xStats
```

UCC script:
```sh
ucc.exe make -nobind
ucc.exe editor.stripsourcecommandlet xStats.u
```

<!-- Markdown link & img dfn's -->
[Server_configfile]: https://github.com/Uniload/xStats/blob/master/(Server)xStats.ini
[Client_configfile]: https://github.com/Uniload/xStats/blob/master/(Client)xStats.ini
