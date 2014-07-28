# hubot-randict

A Hubot script for displaying the random words from [www.weblio.jp][].

## Installation

    $ npm install git://github.com/bouzuya/hubot-randict.git

or

    $ # TAG is the package version you need.
    $ npm install 'git://github.com/bouzuya/hubot-randict.git#TAG'

## Sample Interaction

    bouzuya> hubot help randict
    hubot> hubot randict - display the random words from www.weblio.jp.

    bouzuya> hubot randict
    hubot> 網おこし漁船 - 水産用語。 定置網の網おこし作業は、多くの人手を必要とするので、省人・省力化のため漁労クレーンや、多目的揚網機を多数装備している。
    http://www.weblio.jp/content/%E7%B6%B2%E3%81%8A%E3%81%93%E3%81%97%E6%BC%81%E8%88%B9

See [`src/scripts/randict.coffee`](src/scripts/randict.coffee) for full documentation.

## License

MIT

## Badges

[![Build Status][travis-status]][travis]

[travis]: https://travis-ci.org/bouzuya/hubot-randict
[travis-status]: https://travis-ci.org/bouzuya/hubot-randict.svg?branch=master
