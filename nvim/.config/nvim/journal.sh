#!/bin/bash
noteFileName="$HOME/willydeliege/diary/$(date +%Y-%m-%d).md"

	if [[ ! -f $noteFileName ]]; then
		echo "# Notes for $(date +%Y-%m-%d)" >> $noteFileName
	fi

nvim -c "norm Go" \
	-c "norm i* $(date +%H:%M) " \
	-c "startinsert" $noteFileName

