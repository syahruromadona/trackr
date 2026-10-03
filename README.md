# Trackr

A Strava-style run/ride/walk recorder that runs in the phone browser (installable PWA).

- Big **current speed** (km/h) and pace, with a 2-minute speed graph, for interval training
- **LAP** button with per-lap time, distance, speed and pace
- Live map, distance, time, average pace/speed, elevation gain
- Saved activities with route map and **GPX export**

Geolocation needs HTTPS (or localhost), so serve it from GitHub Pages / Netlify and open it on your phone, then "Add to Home Screen".
Keep the screen on while recording — browsers pause GPS when the page is backgrounded.

## VO2max training

- **Train** tab: estimated VO2max from your best 5-30 min efforts (Daniels/Gilbert formula, GPS glitches filtered), monthly trend, your own logged readings (watch / lab / Cooper test)
- Target speeds per zone derived from the speed at VO2max
- Structured sessions (Norwegian 4x4, 5x3, 6x2, 30/30, 8x1, custom): warm-up, timed work/rest phases with beeps and vibration, live speed coloured against the target band, automatic laps per phase
- Weekly distance
- Back up all / Restore includes activities and VO2max readings

