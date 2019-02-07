# allyourpasswords
The offline password manager. Requires macOS 10.14 or later

### In Action

![](quick.gif)

### No electron

Although I am more proficient at making websites, I don't like electron "apps" taking away all of my battery and spinning up my CPU to 100% randomly, so swift it is.

### The process

I logged every day of the 30 day process it took me to make this thing [here on a dev focused blogging platform](https://dev.to/swlkr/day-1-making-a-native-macos-password-manager-for-people-who-hate-the-cloud-3j68)

### The stack
This is essentially a swift wrapper around SQLite that uses three open source libraries, which is why I was able to get it done in a month as a side project around my full time job.

1. [SQLite.swift](https://github.com/stephencelis/SQLite.swift)
2. [FavIcon](https://github.com/leonbreedt/FavIcon)
3. [SQLCipher](https://github.com/sqlcipher/sqlcipher)

The roles of sqlite.swift and sqlcipher are to read/write to an encrypted sqlite db that gets encrypted with the master password that you set when the app opens up. There are few columns in one table "logins" and that's pretty much it for now. Future versions will be more sophisticated, but for now it does what it says and says what it does. Wait...

### Building

Have a mac running macOS mojave 10.14, open up xcode, hit the play button.

### Support

If you want to support future dev efforts with cold hard cash, you can buy it either from my (very basic) lander here: [allyourpasswords.com](https://allyourpasswords.com) or from the [mac app store here](https://itunes.apple.com/us/app/all-your-passwords/id1450537302?mt=12)

If you don't want to pay the full price of the app in the mac app store, you can use the code ph-50 after you click the buy button on the lander, it uses paddle and devmate, so it requires an email to send the .app file to, just trying to be as upfront as possible here, oh and that code is in the nomas branch of this repo.
