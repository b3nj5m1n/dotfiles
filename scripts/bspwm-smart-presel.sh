#!/bin/bash

# Lets BSPWM send the marked {or just the focused} node to a receptacle
# {or a preselection}.  This script is part of my dotfiles:
# https://gitlab.com/protesilaos/dotfiles.
#
# Copyright (c) 2019 Protesilaos Stavrou <info@protesilaos.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

_bspc_query() {
	bspc query -N -n "$@"
}

_marked_else_focused() {
	if [ -n "$(_bspc_query 'any.marked')" ]; then
		echo 'any.marked'
	else
		echo 'focused'
	fi
}

receptacle="$(_bspc_query 'any.leaf.!window')"

# Use a receptacle if available, else use a preselection.  None is
# limited to the focused desktop.
if [ -n "$receptacle" ]; then
	bspc node "$(_marked_else_focused)" -n "$receptacle" --follow
else
	bspc node "$(_marked_else_focused)" -n 'newest.!automatic' --follow
fi

