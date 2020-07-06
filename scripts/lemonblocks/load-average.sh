#!/bin/bash

printf "[$(uptime | cut -d ',' -f 4 | cut -d ' ' -f 3-)]"
