#!/bin/sh
/home/ch/bin/trash `/usr/bin/notmuch search --output=files $(date +%s -d 2009-10-01)..$(date +%s -d "6 month ago")`
