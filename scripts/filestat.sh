#!/bin/bash

FILE="$1"
DATABASE="$2"

sqlite3 "$DATABASE" \
    "CREATE TABLE IF NOT EXISTS files (
    path TEXT PRIMARY KEY,
    path_rel TEXT,
    permissions INTEGER,
    device_number INTEGER,
    raw_mode TEXT,
    file_type TEXT,
    group_id INTEGER,
    num_hardlinks INTEGER,
    mount_point TEXT,
    size INTEGER,
    device_type INTEGER,
    user_id INTEGER,
    user_name TEXT,
    time_birth INTEGER,
    time_last_access INTEGER,
    time_last_data_modification INTEGER,
    time_last_status_modification INTEGER
    );"

sqlite3 "$DATABASE" \
    "INSERT INTO files (
    path,
    path_rel,
    permissions,
    device_number,
    raw_mode,
    file_type,
    group_id,
    num_hardlinks,
    mount_point,
    size,
    device_type,
    user_id,
    user_name,
    time_birth,
    time_last_access,
    time_last_data_modification,
    time_last_status_modification)
    VALUES
    ('$(realpath "$FILE")', $(stat --printf="%N, %a, %d, '%f', '%F', %g, %h, '%m', %s, %r, %u, '%U', %W, %X, %Y, %Z)" "$FILE")
    ;"


