#!/bin/bash

if [ -z "$1" ]; then
    echo "No arguments supplied."
    echo "First argument should be new atuin database"
    echo "Second argument should be mcfly database to migrate."
    exit
fi

sqlite3 "$2" << EOS
    BEGIN TRANSACTION;
    CREATE TEMPORARY TABLE commands_backup(command,timestamp,exit,cwd,session,id,hostname);
    INSERT INTO commands_backup SELECT cmd,(when_run*1000000000),exit_code,IIF(dir IS NULL, 'UNKOWN', dir),session_id,(('$(hostname)' || ':' || '$USER') || '-' || id),('$(hostname)' || ':' || '$USER') FROM commands;
    DROP TABLE commands;
    CREATE TABLE commands(id, timestamp, duration, exit, command, cwd, session, hostname);
    INSERT INTO commands(id,command,timestamp,exit,cwd,session,duration,hostname) SELECT id,command,timestamp,exit,cwd,session,-1,hostname FROM commands_backup;
    DROP TABLE commands_backup;
    COMMIT;
    SELECT * FROM commands LIMIT 20;
EOS

sqlite3 "$1" << EOS
   attach "$2" as to_migrate;
   BEGIN;
   INSERT OR IGNORE INTO history SELECT * FROM to_migrate.commands;
   COMMIT;
   detach to_migrate;
EOS
