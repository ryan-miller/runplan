# runplan
Some number of runners follow a plan to help them best prepare for an event or goal. These plans are usually structured by logical patterns. This project aims to generate structured run plans based on simple preferences.

# Getting Started
With Ruby installed, clone repo. 

From command prompt see **Usage**.

# Prerequisites
Ruby 3

# Options
Many workout plans have a number of assumptions. Runplan allows for several runtime options. These options are listed here.

|Option|Default|Description|
|------|------:|-----------|
|**planLength**|4|Simply how many weeks the plan should generate|
|**startMinutes**|240|Most running plans are based on **time** not **miles**. Sets the first week's total time of running.|
|**minMinutes**|240|Sets the minimum amount of total time per week Runplan prescribes, including recovery weeks.|
|**maxMinutes**|600|Sets the maximum amount of total time per week Runplan prescribes.|
|**blockSize**|4|A general belief in run planning is there should be a certain number of "build" weeks where volume is increased week over week, followed by a week of recovery, or lowered volume. This determines a "block" in weeks where the last week of the block is a recovery week. If you prescribe there is no need for recovery, for instance, set the **blockSize** to the same value as **planLength** or set **recoveryFactor** to the same as **buildFactor**|
|**buildFactor**|1.2|A general rule of thumb for progressing safely is to not increase running volume more than 10% a week. In base builds, some prescibe a larger increase week over week is OK. This sets how much volume increases week over week. A value of 1.2 increases consecutive build weeks by 20%.|
|**recoveryFactor**|0.85|See **blockSize** for context. Sets the decrease of volume in the last week of each block. The default of 0.85 will reduce the volume by 15% for the last week of each block.|

# Usage
```ruby runplan.rb```

```ruby runplan.rb -min 300 -max 720 -blockSize 3 -buildFactor 1.1```

```...```

# Output
Runplan provides two different run plan strategies. We will refer to them as the 'BarryP' strategy and the 'Roche' strategy.

## BarryP Strategy
The BarryP strategy is based off of a http://forum.slowtwitch.com member. This approach is to run six days a week. There are three short runs, 2 medium runs, and 1 long run where the medium runs are two times as long as the short runs and the long run is three times as long as the short runs. For instance, with easy math, if you run ten hours a week, you would do three 1 hour runs, two 2 hour runs, and one 3 hour run. By default, for now, the single rest day each week is on Monday.

## Roche Strategy
The Roche strategy is from SWAP Running (www.swaprunning.com) coaches, David and Megan Roche. Their strategy is bit more complex. See below for a typical week.

|Day|Type|Amount|
|---|---|---|
|Monday|Rest|Just chill!|
|Tuesday|Aerobic|15% of miles|
|Wednesday|Aerobic or Workout|20% of miles|
|Thursday|Aerobic|15% of miles|
|Friday|Aerobic or Rest|0-10% of miles|
|Saturday|Long run or Long run workout|25-35% of miles|
|Sunday|Aerobic|15% of miles|

Typically Fridays are rest days until a certain volume is reached. Someday a runtime option will be created to specify what the volume threshold is to add Friday runs.

# Sample output
Running `ruby test/runplan_tester.rb` using default values results in the below output. What you choose to do with this output is up to you.

|BARRYP PLAN||||||||||
|---|---|---|---|---|---|---|---|---|---|
|W|       D|      M|       T|       W|       T|       F|       S|       S|       T|
|1|08/02/2021|00:00R|00:24S|00:48W|00:24E|00:48T|00:24E|01:12L|04:00|
|2|08/09/2021|00:00R|00:29S|00:58W|00:29E|00:58T|00:29E|01:26L|04:49|
|3|08/16/2021|00:00R|00:35S|01:09W|00:35E|01:09T|00:35E|01:44L|05:47|
|4|08/23/2021|00:00R|00:41S|01:23W|00:41E|01:23T|00:41E|02:04L|06:53|

R = rest,
W = workout,
E = easy,
S = strides,
L = long,
F = fast finish,
T = tempo


|ROCHE PLAN||||||||||
|---|---|---|---|---|---|---|---|---|---|
|W|       D|      M|       T|       W|       T|       F|       S|       S|       T|
|1|08/02/2021|00:00R|00:36S|00:48W|00:36E|00:00R|01:24L|00:36E|04:00|
|2|08/09/2021|00:00R|00:43S|00:58W|00:43E|00:00R|01:41L|00:43E|04:48|
|3|08/16/2021|00:00R|00:52S|01:09W|00:52E|00:00R|02:01L|00:52E|05:46|
|4|08/23/2021|00:00R|01:02S|01:23W|01:02E|00:00R|02:25L|01:02E|06:54|

R = rest,
W = workout,
E = easy,
S = strides,
L = long,
F = fast finish,
T = tempo

# Roadmap
The moon shot is to build this into an AI enabled multisport annual training plan with inputs from devices and biomarkers including heart rate, resting heart rate, pulse oxygenation, etc. as well as daily human input, but we have to start somewhere.

Shorter term goals include adding abilities for:
* other sports besides running
* multiple workouts per day
* a strength training component
* other strategies besides 'Roche' and 'BarryP'
* daily recommendations based on recent past performance and biomarkers

# Contributing
https://github.com/ryan-miller

# License
See LICENSE (MIT)

# Contact
ryan dot l as in lima dot miller at icloud dot com

# Acknowledgements