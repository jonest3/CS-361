######
#
# RUN AND INIT SCRIPTS FOR FINAL LIVE SITE.. not yet. 
#
#
#
#
#
#npm install
#node server.js
#
####END####
CODEBASE="/home/lori/CS-361/maxwell-try-one"


#write to run log. 

#cd
cd $(CODEBASE)/

#git update refs
git remote update
#git dry run 
if ! git diff --quiet remotes/origin/HEAD; then
git reset --hard HEAD
git clean -xffd
git pull
fi
#do me secretey works
source ../mescrets.sh
update_nodejs

#blah
npm install ./server.js
sleep 30

#check if forever caught it. 
forever list | grep server.js
