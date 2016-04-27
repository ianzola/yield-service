# yield-service

Example is in a free Heroku tier, so expect some slow loading when loading the page the first time

[Click here to open Heroku example](https://yield-service.herokuapp.com/)

### Database

|description        |mday|mday_max|wday|  
|Haircut appointment|  1 |    8   |  3 |  
|Breakfast Meeting  | 15 |        |    |

### Algorithm

The algorithm is based loosely on the `cron` format -- representing repeating dates.

Given a date, it will repeatedly increase the date until it fulfills all the criteria:
- If `mday` is supplied but `mday_max` is NULL, the appointment must happen on the specified day of the month.
- If `mday` and `mday_max` are supplied, the appointment must be between those two dates.
If the given date is not within these ranges, then the algorithm skips ahead to the next date that would satisfy it.

 - If `wday` is supplied, then the appointment must be on a specific day of the week. (0 = Sunday, 3 = Wednesday, 6 = Saturday)
If the given date is not on the correct weekday, then the algorithm skips ahead to the next date that matches.

Whenever a time skip happens, the algorithm resets to ensure that all criteria are re-checked.

#Notes:

- If the entered date has an appointment, it will be returned. (This was my understanding of the spec.)
