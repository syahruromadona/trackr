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
- Birth date and sex are entered in *Coach settings* and are saved on the phone and in the cloud sync (they are also carried in Back up / Restore)
- The coach picks run vs recovery days adaptively from the last 6 days, with a weekly run budget that ramps up about one run a week, and suggests strength on recovery days (log a 20-min session in one tap)
- Today shows active minutes against the 150 min/week guideline and strength sessions against 2/week

## Speed profiles and reps

- Every run keeps a speed profile (one reading per 10 s) so the fast and slow parts survive, unlike a single average
- The saved-activity screen shows a speed chart with the fast parts shaded, the work-only average, the rest-of-run average, the fastest rep and how much the last rep faded
- Interval-style surges are detected in runs that were not recorded as sessions, and count as hard days for the coach
- The VO2max estimate uses the profile (3, 4, 5, 8, 12, 20 and 30 minute windows)
- Restoring a backup that carries profiles upgrades activities you already have

## Recording accuracy

- The speed profile is built from position change (like Strava's files, so recordings and history compare like for like). The phone's own satellite-Doppler speed is recorded beside it for comparison: in a Cooper test it read 5-10% lower than position speed while running, so the app does not trust it blindly
- Every fix keeps the phone's exact timestamp (milliseconds), so recordings do not have the 1 s / 2 s timestamp rounding seen in Strava's GPX files
- Cadence (steps per minute) is read from the motion sensor while recording and shown live and on the saved activity (whole run, fast parts vs the rest). Best with the phone in an armband, pocket or waistband; iPhone asks for motion permission once
- The in-progress draft is written at most every 3 s (and whenever the page is hidden) to keep long recordings light

## Recording flow and weekly review

- The Record screen says plainly whether anything is being recorded: "Not recording" until Start, "Recording" with a pulsing dot, "Paused"
- A coached plan can skip its warm-up ("Already warmed up") so the main part starts the moment you press Start
- Finish is always available while recording (with a confirmation), next to Lap/Next and Pause
- After a session the Today card explains the result in plain words; after the 12-minute test it shows distance, VO2max, where that puts you, 3-minute pace splits and what changes in your targets
- **Weekly review with Claude** (Today tab): one tap copies a plain-text summary (last 4 weeks, VO2max, bests, last 10 sessions, today's plan, three reflection questions, optional one-line goal) to paste into Claude. No locations or names

## Sensor check

Coach settings (Today tab) has a 15-second **motion sensor check**. It reports whether the browser sends motion data at all,
whether the permission is blocked (with the exact fix), the readings per second, and whether the app can count steps for cadence.
The last result is kept and included in the weekly summary. Recordings also store how many motion readings arrived (`mot`),
so a session with no cadence can be explained afterwards.

## Cloud sync (Supabase)

- Activities, VO2max readings, coach settings, profile and today's rest-day flag are copied to a Supabase project and shared by every device running Trackr. The in-progress recording, sensor check and map style stay on each device
- The phone's own storage is still what the app reads and writes, so recording works with no signal; changes upload a couple of seconds later, when the app comes back to the foreground, when the connection returns, and every 5 minutes. *Activities → Cloud sync* shows the status and has a *Sync now* button
- The first sync on a device uploads everything already on it and downloads everything else
- Deleting an activity marks it `deleted` in the database (the row stays, so it can be recovered from the Supabase table editor)
- Setup: run [`supabase/trackr.sql`](supabase/trackr.sql) once in the project's SQL editor, and put the project URL and publishable key in `SUPABASE_URL` / `SUPABASE_KEY` near the end of `index.html`
- There is no sign-in. The publishable key is public in this repo, so anyone who has it can read and change the synced data
