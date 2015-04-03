Zipranger
=========

As part of the Redbubble book club learn Haskell initiative...

Takes a list of 'zipcode','state' and works out the range of zip codes for each state.

So
```
"code","state"
"00210","NH"
"00211","NH"
"00212","NH"
"01057","MA"
"01059","MA"
"01060","MA"
"01061","MA"
```

Should become

```
MA => 01057..01061
NH => 00210..00212
```

List of zip codes based on http://www.boutell.com/zipcodes/zipcode.zip

To run

```
cabal sandbox init
cabal install --only-dependencies
cabal run zipcode.csv
```

