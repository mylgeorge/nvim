#!/bin/sh

git filter-branch -f --env-filter '

OLD_EMAIL="vagrant@docman"
CORRECT_NAME="Giorgos Mylonas"
CORRECT_EMAIL="mylgeorge@gmail.com"

if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
    export GIT_COMMITTER_DATE="Fri Apr 6 16:55:52 2018 +0300"
' --tag-name-filter cat -- --branches --tags
