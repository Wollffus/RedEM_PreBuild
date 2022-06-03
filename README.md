# RedEM_PreBuild

A pre-built RedM server using the RedEM:RP framework. This is a basic server build, with only public resources.
This is not a plug and play server download. You still will have to take a few steps in getting it set up to your preferences.

# Youtube tutorial

[Video Tutorial](https://youtu.be/1Y0SLUre8BQ) Click here for a youtube tutorial, or paste the link in your browser

# Lets get started

You will need server artifacts. Head to the link below and download the latest recommended build.
https://runtime.fivem.net/artifacts/fivem/build_server_windows/master/

- To unzip your server artifacts, you will need a zip/rar reader, a user friendly one is (https://www.win-rar.com/download.html?&L=0)
- Download the files from the RedEM_PreBuild Github
- Un-Zip the RedEM_PreBuild folder
- In your search bar, type "This PC"
- Select the drive you want the server saved on (In the default preview we used the C: drive)
- Take the un-zipped RedEM_PreBuild file and drag it to the drive you want to use
- You should have already downloaded the latest recommended server build artifacts, if you have not, do so now.
- Un-zip the server artifacts folder and drag the server folder and drop it in your RedEM_PreBuild folder.
- RedEM_PreBuild folder should now have TWO(2) folders inside it, the original server-data folder that came with the download
  and the server folder that you just added.
- You will need cfx-server-data, go here and download it https://github.com/Wollffus/cfx-server-data
- Un-zip the cfx-server-data folder
- open RedEM_PreBuild > server-data > resources
- Drag [gamemodes], [gameplay], [local], [managers], [system], and [test] from the cfx-server-data folder and add them to RedEM_PreBuild > server-data > resources

Open your ports
 - Go to your PC search bar again, and type "Windows Defender Firewall with Advanced Security"
 - 1 Click on inbound rules
 - 2 Click New Rule
 - 3 Click Port, than click next
 - 4 Click TCP, than click specific local ports and type 30120 (or 30110 if your using that port), click next
 - 5 Make sure you click Allow the Connection, and click next
 - 6 Make sure Domain, Private and Public are all checked off, click next
 - 7 Name it RedM or something you want and click finish

Repeat steps 1-4 but now instead of doing TCP, click UDP
repeat steps 5-7

Next you will click on Outbound rules, then repeat steps 2-7 for both TCP and UDP just like you just did for the inbound rules.

*Note* You may need to open ports 3306 as well, for your Xammp

You will also need a database set up, here is a common user friendly one.
- https://www.heidisql.com/

You will need a form of Apache distribution, here is a common user friendly one.
- https://www.apachefriends.org/download.html


# Credits

- [RedEM:RP Framework](https://github.com/RedEM-RP)
- [RedEM Roleplay](https://github.com/RedEM-RP/redem_roleplay)
- [RedEM Menu Base](https://github.com/RedEM-RP/redemrp_menu_base)
- [RedEM Notification](https://github.com/Ktos93/redemrp_notification)
- [RedEM Clothing](https://github.com/RedEM-RP/redemrp_clothing)
- [RedEM Identity](https://github.com/RedEM-RP/redemrp_identity)
- [RedEM Skin](https://github.com/RedEM-RP/redemrp_skin)
- [RedEM Inventory](https://github.com/RedEM-RP/redemrp_inventory)
- [RedEM Respawn](https://github.com/RedEM-RP/redemrp_respawn)
- [RedEM Status](https://github.com/RedEM-RP/redemrp_status)
- [RedEM Dialog](https://github.com/RedEM-RP/redemrp_dialog)
- [RedEM Quest](https://github.com/RedEM-RP/redemrp_quests)
- [RedEM Infection](https://github.com/RedEM-RP/redemrp_infection)
- [RedEM Shops](https://github.com/RedEM-RP/redemrp_shops)
- [RedEM Farmerjob](https://github.com/RedEM-RP/redemrp_farmerjob)
- [RedEM Progress Bars](https://github.com/RedEM-RP/redemrp_progressbars)
- [RedEM Banking](https://github.com/Ktos93/redemrp_banking)
- [Poke Miner Job](https://github.com/PokeSer/poke_minerjob)
- [Police Job](https://github.com/mrlupo/ml_policejob)
