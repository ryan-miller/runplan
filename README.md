# runplan
Some number of runners follow a plan to help them best prepare for an event or goal. These plans are usually structured by logical patterns. This project aims to generate structured run plans based on simple preferences.

## Getting Started
Clone repo. 

## Prerequisites
Ruby 3

## Options
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

## Usage
```ruby runplan.rb```

```ruby runplan.rb -min 300 -max 720 -blockSize 3 -buildFactor 1.1```

```...```

## Roadmap

## Contributing
@itsryeguy

## License

## Contact
ryan dot l as in lima dot miller at icloud dot com

## Acknowledgements