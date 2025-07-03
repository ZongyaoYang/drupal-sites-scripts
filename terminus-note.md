```bash

#Synce LIVE to DEV

terminus env:clone-content eol-unity.live dev --yes

#Open Database with Pan Cake

terminus pc eol-unity.dev
terminus pc eol-unity.live

#check database version

terminus drush eol-unity.live -- sqlq "SELECT VERSION();"

```
