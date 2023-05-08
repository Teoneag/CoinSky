# CoinSky
By Teodor Neagoe
## Goals for this app
1. A wallet, where u can do everything related to crypto: view, buy, sell, use leverage, learn
2. As intuitive as possible
3. Secure
4. Fast and no bugs
5. U can coppy trade like on etoro

## TO DO
### Urgent
- refresh, and refresh after resetting wallet
- check why the ballance isn't updateing
- handdle errors

### Theme
- add the theme switch in the settings (3 options: dark, system default, white) + instead of white, use smth more easy on the eye
- make the theme button from appBar animate: sun -> moon
- color red, green and gray things that change
- add the theme in the database
- add loading screen + splash screen
- delete the dot from the logo to make it centered when i need it
### General
- make a responsive layout
- make different languages available
- hide the notificationbar
- handle exceptions and errors
- solve warnings
- after update, it's very buggy (maybe refresh or smth?)
### User
- add different log in methodes
- add username check + mail check + password check?
- user img (display it instead of the user button on the appbar)
- after register, autocomplete mail in login
- At the login and register screens, add some welcome text + option to skip loggin
- autocomplete @gmail.com
- solve the bug after login (user is null or smth)
### List view
- Is 24hmarketcap the same as 24h volume?
- update coins every 1 second or when u refresh (refersh indicator) + refresh button from app bar
- add the sparkline to the list
- sort by table head item
- at 743. it gets stuck
- i should remove the bg colour of the icon
- 9-10, 99-100 they are not alineated
- when u get to the end of the table, dispay table end
- add the coin vs coin on exchange: https://min-api.cryptocompare.com/data/v2/pair/mapping/exchange/fsym?exchangeFsym=BTC&limit=1000&exchange=binance
- change error coin img/handle it differently
- add an i button after the 'end of list', show: To add a coin to favorites: Tap on a coin on the trades page, and then star it.
### Coin screen
- solve the threshhold problem
- When u can't buy or sell smth, make the button gray
- solve the delay with the snakebar
### Positions
- execute an order only if there are no errors (not allow negative balance)
- add create, delete, modify virtual portofolio
- add real money positions
- pup-up before buying?
- make more efficient when calculating the ballance: request all the data in only one http request
### Settings page
- theme
- user: log out, delete account
### Home page
- Add welcome/welcome back

# Maybe usefull
- visualDensity: VisualDensity.adaptivePlatformDensity, (in ThemeData)
- elevation (AppBar)
- ChangeNotifierProvider
- await DesktopWindow.setMinWindowSize(const Size(600, 800));

# Chosing API
For now: CryptoCompare: simple, free, most popular, lots of tutorial
When i wanna be able to buy and sell: binance api
- i want to request every 2 seconds new values
1. CoinMarketCap: u get only 1000 free credits and i need at least 0 x 60 x 60 x 24 x 30 = 51,840,000 requests per month
2. CoinGecko API: most popular, only 1 year hystorical data
3. CryptoCompare api: very popular, already example with flutter 
- I already build some functionalities with binance api and coingecko but the 10-30 request a min are too little for me