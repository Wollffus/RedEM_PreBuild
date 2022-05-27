# esplugin_mysql

An MySQL plugin for [RedEM](https://github.com/kanersps/redem) and [RedEM:RP](https://github.com/RedEM-RP/redem_roleplay).

## Installation

**If using for RedEM: Roleplay then you don't need to do what's below, just follow RedEM: Roleplay's install instructions instead!**

- Download esplugin_mysql
- Make sure you have [mysql-async](https://github.com/amakuu/mysql-async-temporary) installed and working
- Utilize FXMigrant if that doesn't work use the below one
  - Import the SQL file provided with this project, `esplugin_mysql.sql` (Also be sure to remove the dependency from fxmanifest.lua)
- Add the following convar in your server configuration file: `set es_enableCustomData 1`. Make sure you put it directly above `mysql_connection_string`
- Make your load order is correct. Here's how it should look:

```bash
ensure esplugin_mysql
ensure mysql-async
ensure redem
ensure redem_roleplay
```
