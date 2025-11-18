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

1. Create the user ```dev-mock```

```
terminus drush climatedataguide-unity.date-field -- user:create dev-mock --mail="dev-mock@example.com"
```

2. Set password
   
```
terminus drush climatedataguide-unity.date-field -- user:password dev-mock --password="pantheon123"
```

3. Add adminnistrator role

```
terminus drush climatedataguide-unity.date-field -- user:role:add "administrator" dev-mock
```

4. Unblock user via CLI

```
terminus drush climatedataguide-unity.date-field -- user:unblock dev-mock
```

5. Login the user via CLI

```
terminus drush climatedataguide-unity.date-field -- uli --name=dev-mock
```
