# Analysis of cold + regrowth time-course expression data

## Organization of dirs

For each reference day and tissue separate directories and analyses are done.
Numbers of scripst presents order of processing, some have the same number - branching points

## Scheme of comparisons

__*expr001__ - analyses using p-value <= 0.01 in differential expression tests

### Penultimate day of cold as reference

Dirs and files with **one** in name

Using only subset of data for SAM / leaf (*depending on directory*) and design matrix to extract interesting comparisons.

We have four days, two of which are cold (c1, c2) and two of which are warm (r1, r2 "regrowth") with one-day break (b).

c1 - c2 - b - r1 - r2

---

For *historical* reasons the following names will be used

d1 - d2 - b - d3 - d4

---

In each day we have three samples: dawn, day, and dusk.

c1[dawn, day, dusk] - c2[dawn, day, dusk] - b - r1[dawn, day, dusk] - r2[dawn, day, dusk]

And we want to compare:

c2[dawn, day, dusk] *vs* c1[dawn, day, dusk]
r1[dawn, day, dusk] *vs* c1[dawn, day, dusk]
r2[dawn, day, dusk] *vs* c1[dawn, day, dusk]

So in all there are 12 time points and we have 9 comparisons.

There are four inbred lines so the same analysis must be dona for each.

### Last day of cold as reference

Dirs and files with **two** in name

Using only subset of data for SAM / leaf (*depending on directory*) and design matrix to extract interesting comparisons.

We have four days, two of which are cold (c1, c2) and two of which are warm (r1, r2 "regrowth") with one-day break (b).

c1 - c2 - b - r1 - r2

Here two regrowth points are compared to the second (last) day of cold.

And here we want to compare:

r1[dawn, day, dusk] *vs* c2[dawn, day, dusk]
r2[dawn, day, dusk] *vs* c2[dawn, day, dusk]

So in all there are 9 time points and we have 6 comparisons.

There are four inbred lines so the same analysis must be done for each.
