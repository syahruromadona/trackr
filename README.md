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


## Daily coach (Today tab)

The app opens on **Today**: a briefing that reads your history and tells you what to do.

- Weekly shape from your run days (interval / threshold / easy / long), set in *Coach settings*
- Guards: no hard session the day after a hard one, easy when the last 7 days are far above your 4-week average, gentle comeback after 14+ days off
- Adaptive levels: step up only after a session completed on target, repeat otherwise, drop a level after a 3-week gap
- One tap starts the session on the Record screen with timed phases, beeps and speed targets; results (reps done, average vs target) feed the next briefing
- 12-minute Cooper test logs a VO2max reading when no baseline exists
- Shows whether you are at your usual running spot

## Longevity focus

- **Train → Longevity** compares your VO2max with age/sex norms (FRIEND registry 2022, treadmill-measured) and shows the value needed for the 25th, 50th, 75th and 90th percentile
- Birth date and sex are entered in *Coach settings* and stay on the phone (they are also carried in Back up / Restore)
- The coach picks run vs recovery days adaptively from the last 6 days, with a weekly run budget that ramps up about one run a week, and suggests strength on recovery days (log a 20-min session in one tap)
- Today shows active minutes against the 150 min/week guideline and strength sessions against 2/week
