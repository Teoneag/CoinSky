# coin_sky_0

## Goals for this app
1. A wallet, where u can do everything related to crypto: view, buy, sell, use leverage, learn
2. As intuitive as possible
3. Secure
4. Fast and no bugs
5. U can coppy trade like on etoro

## TO DO
Make coin page (stats + graph of the coin + like the coin)
login + firebase
Virtual portofolio + virtual trades
0. Add the sparkline to the list
1. Theme
- Add the theme switch in the settings (3 options: dark, system default, white) + instead of white, use smth more easy on the eye
- Make the theme button from appBar animate: sun -> moon
2. Make different languages available
3. Add different log in methodes
4. Make a responsive layout
5. Hide the notificationbar
6. when u tap on the icon of the app, u go to the home page of the home screen
7. add reset to settings
8. Update coins every 1 second or when u refresh (refersh indicator)
9. Delete the background of every coin
10. Is 24hmarketcap the same as 24h volume?
11. Handle exceptions
12. color red, green and gray things that change
13. enable swiping between pages (physics scroll...)
14. Theme is in the database
14. HomePage: Sparkline, Refresh, tableHead, sort by table head item, at 743. it gets stuck, i should remove the bg colour of the icon, 9-10, 99-100 they are not alineated, when u get to the end of the table
15. Add the coin vs coin on exchange: https://min-api.cryptocompare.com/data/v2/pair/mapping/exchange/fsym?exchangeFsym=BTC&limit=1000&exchange=binance
16. Add loading screen + splash screen
17. Add username check + mail check + password check?
18. In settings add delete user
19. After register, autocomplete mail in login
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