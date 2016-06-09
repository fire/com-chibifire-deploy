name "server"
description "Snappydata server"
run_list "recipe[snappydata]", "recipe[snappydata-ycsb]"