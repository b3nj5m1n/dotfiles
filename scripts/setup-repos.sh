#!/usr/bin/env sh

USER=b3nj4m1n

GIT_SSH_COMMAND="ssh -i /home/$USER/.ssh/dk_sh_history -o StrictHostKeyChecking=no" git clone git@github.com:b3nj5m1n/sh_history.git /home/$USER/.local/share/sh_history 2>/dev/null
GIT_SSH_COMMAND="ssh -i /home/$USER/.ssh/dk_tasks -o StrictHostKeyChecking=no" git clone git@github.com:b3nj5m1n/tasks.git /home/$USER/.local/share/task 2>/dev/null
GIT_SSH_COMMAND="ssh -i /home/$USER/.ssh/dk_timew -o StrictHostKeyChecking=no" git clone git@github.com:b3nj5m1n/timew.git /home/$USER/.local/share/timew/data 2>/dev/null
GIT_SSH_COMMAND="ssh -i /home/$USER/.ssh/dk_logseq -o StrictHostKeyChecking=no" git clone git@github.com:b3nj5m1n/logseq-db.git /home/$USER/.local/share/logseq 2>/dev/null
