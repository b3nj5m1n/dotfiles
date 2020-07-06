#!/bin/bash

printf "[uptime: $(uptime | cut -d ' ' -f 2 | cut -d ':' -f 1-2)]"
