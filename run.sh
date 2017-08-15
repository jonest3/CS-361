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
CODEBASE="/home/lori/live"

# localhost/loopback
sudo iptables -t nat -I OUTPUT -p tcp -d 127.0.0.1 --dport 80 -j REDIRECT --to-ports 3000
# external routing
sudo iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 3000
 
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
#sleep 30

#check if forever caught it. 

forever list

#at this point, either run > node server.js 
# in the live directory, this is the fastest for dev. 
# if you are going to leave the live site standing up 
# use > forever -m 100 start server.js
# to kill a forever started server.
# > forever stop [number of the server, usually 0]
# or if there are runaways or super dead ones. 
# > forever killall (?syntax)

