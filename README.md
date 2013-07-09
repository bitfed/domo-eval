# Eval plugin for [Domo](https://github.com/rikukissa/domo)

Asks [Domo](https://github.com/rikukissa/domo)
 politely to evaluate your JavaScript/CoffeeScript

## Installation

```
npm install domo-eval
```
Add domo-eval to Domo's configuration or load it with the !load command

## Usage

```
!eval [flags] <Javascript/CoffeeScript>
```
## Flags

* -c
    * Evaluate CoffeeScript
    * With -v flag outputs only the compiled JavaScript

## Examples

**!eval var a = 1; a + 2;**
```
00:47 Domo: 3
```

**!eval -c a = (word for word in ['hello', 'world']).join ' '**
```
00:50 Domo: 'hello world'
```

**!eval -c -v a = (word for word in ['hello', 'world']).join ' '**
```
00:50 Domo: var a, word;
00:50 Domo: a = ((function() {
00:50 Domo:  var _i, _len, _ref, _results;
00:50 Domo:  _ref = ['hello', 'world'];
00:50 Domo:  _results = [];
00:50 Domo:  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
00:50 Domo:    word = _ref[_i];
00:50 Domo:    _results.push(word);
00:51 Domo:  }
00:51 Domo:  return _results;
00:51 Domo: })()).join(' ');

```