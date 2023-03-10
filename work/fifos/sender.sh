#!/bin/bash
tail -f -n0 /common/queue.txt |
       while read line; do 
	       ./abarbeiter.sh $(echo -n "$line") 
       done      
