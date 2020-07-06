#!/bin/bash

printf "[$(uptime | grep -ioe "load average: [[:digit:]]*.[[:digit:]]*")]"
