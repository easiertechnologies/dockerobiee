#!/bin/bash


docker run -d \
-p 32855:9508 \
-p 32849:9514 \
-p 32848:9799 \
-p 32861:9502 \
-p 32858:9505 \
-p 32856:9507 \
-p 32854:9509 \
-p 32863:9500 \
-p 32859:9504 \
-p 32851:9512 \
-p 32850:9513 \
-p 32862:9501 \
-p 32860:9503 \
-p 32857:9506 \
-p 32853:9510 \
-p 32852:9511 \
--name obiee --stop-timeout 600 \
-e "BI_CONFIG_RCU_DBSTRING=$ip:1521:orclpdb1" -e "BI_CONFIG_RCU_PWD=Admin123" \
mdaviscatg/obiee
