# Get current path
set PAST $PWD
cd /etc/nixos

# Update Git Main Branch
git checkout refactorv2
git pull
git add .
git commit -m "[SCRIPT] Updated dot files! 🚀"
git push

# Go back
cd $PAST
