#!/bin/bash

layout=$(setxkbmap -query | grep layout | awk '{print $2}')

echo ^c#ff0066^$layout
