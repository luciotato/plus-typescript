set -v
npm run build:compiler
cp built/local/tsc.js lib/tsc.js
cp built/local/tsserver.js lib/tsserver.js

