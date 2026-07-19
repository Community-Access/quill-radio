# Quill Radio Weather -- User Guide

Quill Radio includes a **Weather** menu that brings official U.S. weather to
you as clear, screen-reader-first text: current conditions, the forecast, and
-- most importantly -- active watches, warnings, and advisories for the places
you care about.

It uses the free **National Weather Service** API (api.weather.gov). There is
no account, no sign-up, and no API key. Nothing is sent anywhere except your
request for weather at a location you choose.

## A safety note first

Quill Weather is an **additional** accessible weather tool. Delivery can be
delayed or interrupted by network, device, or provider problems. Do not rely on
it as your only source of emergency information. Keep a NOAA Weather Radio,
Wireless Emergency Alerts, and local emergency instructions as your primary
safety channels.

## Adding your first location

1. Open the **Weather** menu and choose **Add Location...** (or open **Weather
   Now...** and press the **Add Location** button).
2. Type one of:
   - a 5-digit **ZIP code** (for example, `85701`),
   - a **city and state** (for example, `Tucson, AZ`), or
   - **coordinates** (for example, `32.2, -110.9`).
3. Optionally give it a friendly **name** such as `Home` or `Mom's`.
4. Press **Add**. Quill looks the place up and saves it. The first location you
   add becomes your primary location.

You can add as many locations as you like and switch between them in Weather
Now with the **Location** chooser.

## Weather Now

**Weather menu > Weather Now...** (or **Ctrl+Shift+W**) opens the Weather
Center. It reads top to bottom in priority order:

1. **Active Alerts** -- a list of any watches, warnings, and advisories, most
   severe first. Arrow through them; the full official text, including the
   **instructions**, appears in the box just below. If there are none, the list
   says so.
2. **Current conditions** -- the latest observation (temperature, sky, wind,
   humidity) from the nearest reporting station.
3. **Forecast** -- the period-by-period forecast ("This Afternoon", "Tonight",
   and so on). Arrow through the list; each period's detailed text appears
   below it.
4. A **status line** naming the National Weather Service office and the
   observation station, so you always know where the data came from.

Press **Refresh** at any time to pull the latest. **Close** leaves any radio
you are playing untouched.

## Quick Weather

**Weather menu > Quick Weather** (or **Ctrl+Shift+Q**) announces a one-line
summary of your primary location without opening a window -- for example:

> Tucson, AZ. 96 degrees F and mostly clear. Wind WNW 5 mph. One active alert;
> highest is Excessive Heat Warning.

You choose what that line includes in Settings.

## Active Alerts

**Weather menu > Active Alerts...** opens Weather Now with focus already on the
alerts list, so you can review warnings with the fewest keystrokes.

## Settings

**Weather menu > Settings...** controls:

- **Units** -- temperature in Fahrenheit or Celsius; wind in mph, km/h, knots,
  or m/s.
- **Forecast periods to show** -- how many periods Weather Now lists.
- **Alert severity to show** -- show everything, or only Moderate and above,
  Severe and above, and so on -- plus a list of specific **event names to
  hide** (one per line).
- **Refresh interval** -- how often Weather Now refreshes (never faster than
  the NWS-recommended minimum).
- **Quick Weather line** -- turn feels-like temperature, wind, humidity, the
  active-alert count, and data age on or off.

## What's coming later

This release shows weather as **text**. Later phases of Quill Weather add spoken
weather with its own voices and interruption rules, background alert monitoring
that keeps watch while the window is closed, and a NOAA Weather Radio stream
explorer. See `QUILL-Weather-PRD.md` for the full roadmap.
