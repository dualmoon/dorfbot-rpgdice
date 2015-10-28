# Dorfbot RPGDice

Rolls dice!

[![Build Status](https://travis-ci.org/dualmoon/dorfbot-rpgdice.png)](https://travis-ci.org/dualmoon/dorfbot-rpgdice)

Compatible with [Dorfbot](https://github.com/sprngr/dorfbot) and [Hubot](https://hubot.github.com/), see [`src/rpgdice.coffee`](src/rpgdice.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install dorfbot-rpgdice --save`

Then add **dorfbot-rpgdice** to your `external-scripts.json`:

```json
[
  "dorfbot-rpgdice"
]
```

## Usage sample

```
User1> hubot roll 5d20
Hubot> 14,11,13,10,13

User1> hubot roll 1d6
Hubot> 5

User1> hubot roll 2d6
Hubot> 2,3
```
