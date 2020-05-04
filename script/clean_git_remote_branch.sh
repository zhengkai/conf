#!/bin/bash
echo "The following remote branches are fully merged into master and will be removed:"
echo
git branch -r --merged master | sed 's/ *origin\///' | grep -v 'master$'
echo

read -p "Continue (y/n)? "
if [ "$REPLY" == "y" ]; then
	# Remove remote fully merged branches
	git branch -r --merged master | sed 's/ *origin\///' | grep -v 'master$' | xargs -I% git push origin :%
	echo "Done!"
fi
