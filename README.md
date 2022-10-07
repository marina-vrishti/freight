# README

This is a test task, see more details at https://github.com/shypple/take-home-exercise

* rvm install 3.2.1 

* rvm use gemset freight@3.2.1 --create

* rake db:create

* rspec spec # with Internet connection for VCR

Few notes

* Why not just rgl gem with inbuilt dejkstra?

1) Because it works only when there is one edge between nodes as the weighs\edges addition is based on Hash and Hash can have only unique keys.
2) Because I would like to take in consideration arrival and departure dates. E.g. ship with some cargo arrived from Rotterdam to Lisbon at 12.12.1970, than the next ship from Lisbon can't depart earlier than that. This sailing would be impossible in real life.

* The example result from the PLS-0001 task (the cheapest direct sailing) is not correct.

The correct one is 
```
[
  {
    "origin_port": "CNSHA",
    "destination_port": "NLRTM",
    "departure_date": "2022-01-30",
    "arrival_date": "2022-03-05",
    "sailing_code": "MNOP",
    "rate": "456.78",
    "rate_currency": "USD"
  }
]
```
* Do the task names (PLS-0001, WRT-0002, TST-0003) stand for Please Write Tests? 
