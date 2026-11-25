// Copies the web app into www/ (what Capacitor packs into the APK). index.html stays the single source.
const fs = require('fs');
fs.rmSync('www', { recursive: true, force: true });
fs.mkdirSync('www');
for (const f of ['index.html', 'offline.html', 'manifest.json', 'sw.js', 'icon-192.png', 'icon-512.png', 'apple-touch-icon.png']) fs.copyFileSync(f, 'www/' + f);
console.log('www/ ready');
