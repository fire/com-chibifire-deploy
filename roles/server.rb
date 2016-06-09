name "server"
description "Snappydata server"
run_list "recipe[apt-upgrade-once]", "recipe[snappydata]", "recipe[snappydata-ycsb]"