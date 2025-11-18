```bash

# Synce LIVE to DEV
terminus env:clone-content eol-unity.live dev --yes

#Open Database with Pan Cake
terminus pc eol-unity.dev
terminus pc eol-unity.live

#check database version
terminus drush eol-unity.live -- sqlq "SELECT VERSION();"

#Display what modules would be installed but don't install them
terminus drush mmm-unity.dev -- pm:install --simulate opensky_publications

#Enable custom module from upstream
terminus drush mmm-unity.dev -- pm:install opensky_publications

#Uninstall a module
terminus drush acom-unity.live -- pmu staff_data

#Retrieve data for a custom module
terminus drush mmm-unity.dev -- opensky-publications:sync

#Give a person admin role
terminus drush hao-unity.live -- user-add-role "administrator" zyang

#Create a user based on the email address
terminus drush cesm-unity.dev -- user:create zyang --mail='zyang@ucar.edu'
```

# Create mock user on multi-dev
