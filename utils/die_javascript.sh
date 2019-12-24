### Removes Node and NPM from mac OS ###
# Uninstall using NPM
npm uninstall npm -g || echo "NPM uninstall didn't work"
# Try if Node's installed with Brew
(brew uninstall node && brew prune) || echo "Node was not installed with Brew"
# Remove all files and folders including Node or NPM
rm -rf /usr/local/{lib/node{,/.npm,_modules},bin,share/man}/{npm*,node*,man1/node*}
rm -rf /usr/local/bin/npm /usr/local/share/man/man1/node* /usr/local/lib/dtrace/node.d ~/.npm ~/.node-gyp /opt/local/bin/node opt/local/include/node /opt/local/lib/node_modules
rm -rf /usr/local/{lib/node{,/.npm,_modules},bin,share/man}/npm*
rm -rf /usr/local/include/node*
rm -rf /usr/local/share/man/man1/node*
rm -rf /usr/local/share/man/man1/npm*
rm -rf /usr/local/share/man/man5/npm*
rm -rf /usr/local/share/man/man7/*npm*
rm -f /usr/local/share/man/man5/package.json.5
rm -f /usr/local/share/man/man5/package-lock.json.5
rm -f /usr/local/share/systemtap/tapset/node*
rm -rf /usr/local/share/doc/node*
# Now you're good to live happily ever after
tput setaf 2; echo "################# It's gone! I can see the shire. #################"; tput sgr0;
