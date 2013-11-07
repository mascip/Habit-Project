// Generated by CoffeeScript 1.6.3
(function() {
  'use strict';
  var CreateResults, app, app_name,
    __slice = [].slice;

  app_name = "myApp";

  app = angular.module("" + app_name + ".services", []);

  app.value('version', '0.1');

  app.factory('CreateResults', function() {});

  CreateResults = (function() {
    function CreateResults() {
      var results, resultsArgs;
      resultsArgs = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      results = _.map(resultsArgs, function(args) {
        return SingleResult.apply(null, args);
      });
    }

    return CreateResults;

  })();

  app.factory('Habit', function() {
    var Habit;
    return Habit = (function() {
      function Habit(name) {
        this.name = name;
      }

      return Habit;

    })();
  });

  app.factory('ActiveHabit', function(Habit) {
    var ActiveHabit;
    return ActiveHabit = (function() {
      function ActiveHabit(name, nbDaysToInit, prevResults) {
        var currentResult, currentStreak, emptyHabit;
        if (nbDaysToInit == null) {
          nbDaysToInit = 0;
        }
        if (prevResults == null) {
          prevResults = [];
        }
        this.habit = new Habit(name);
        this.name = this.habit.name;
        emptyHabit = prevResults.length === 0;
        if (nbDaysToInit > 0 && !emptyHabit) {
          addalert("Defect: to create a Habit, it must either have previous results, or past days to initialize; not both");
        }
        currentStreak = emptyHabit ? 0 : _.first(prevResults).streak;
        currentResult = {
          day: moment().startOf('day'),
          dateTime: 0,
          streak: currentStreak,
          ticked: 'unknown'
        };
        this.results = _.clone(prevResults);
        this.results.unshift(_.clone(currentResult));
        this.updateAllStreaks();
        this.dayIdx = 0;
        this.notTickedToday = true;
      }

      ActiveHabit.prototype.streakOnDay = function(daysAgo) {
        return this.results[daysAgo].streak;
      };

      ActiveHabit.prototype.tickedOnDay = function(daysAgo) {
        return this.results[daysAgo].ticked;
      };

      ActiveHabit.prototype.nbDaysSinceStart = function() {
        return this.results.length;
      };

      ActiveHabit.prototype.nbWeeksStarted = function(daysAgo) {
        if (daysAgo == null) {
          daysAgo = 0;
        }
        return Math.ceil((this.nbDaysSinceStart() - daysAgo) / 7);
      };

      ActiveHabit.prototype.nbDaysInWeek = function(weekNum) {
        return Math.min(7, this.nbDaysSinceStart() - 7 * weekNum);
      };

      ActiveHabit.prototype.nbWeeksToDisplay = function(daysAgo) {
        if (daysAgo == null) {
          daysAgo = 0;
        }
        return Math.min(2, this.nbWeeksStarted(daysAgo));
      };

      ActiveHabit.prototype.currentWeekNumbet = function() {};

      ActiveHabit.prototype.clickTick = function(daysAgo) {
        var ticked;
        ticked = this.tickedOnDay(daysAgo);
        this.results[daysAgo].ticked = (function() {
          switch (false) {
            case ticked !== 'unknown':
              return 'done';
            case ticked !== 'done':
              return 'failed';
            case ticked !== 'failed':
              return 'done';
            default:
              return 'failed';
          }
        })();
        if (this.dayIds === 0) {
          this.notTickedToday = false;
        }
        return this.updateAllStreaks();
      };

      ActiveHabit.prototype.emptyHabit = function() {
        return this.results.length === 0;
      };

      ActiveHabit.prototype.updateAllStreaks = function() {
        var i, _i, _ref;
        if (!this.emptyHabit()) {
          this.firstResult().streak = this.calcStreak(this.firstResult().ticked, 0);
          if (this.results.length > 1) {
            for (i = _i = _ref = this.results.length - 2; _ref <= 0 ? _i <= 0 : _i >= 0; i = _ref <= 0 ? ++_i : --_i) {
              this.results[i].streak = this.calcStreak(this.results[i].ticked, this.results[i + 1].streak);
            }
          }
        }
        return this.countAllResults();
      };

      ActiveHabit.prototype.countAllResults = function() {
        var res, _base, _i, _len, _ref;
        this.countResults = _.countBy(this.results, function(result) {
          return result.ticked;
        });
        _ref = ['unknown', 'done', 'fail'];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          res = _ref[_i];
          (_base = this.countResults)[res] || (_base[res] = 0);
        }
        return this.countResults.total = this.results.length - this.countResults['unknown'];
      };

      ActiveHabit.prototype.firstResult = function() {
        return _.last(this.results);
      };

      ActiveHabit.prototype.calcStreak = function(tick, prevStreak) {
        switch (false) {
          case tick !== 'unknown':
            return prevStreak;
          case tick !== 'done':
            return this.increaseStreak(prevStreak);
          case tick !== 'failed':
            return this.decreaseStreak(prevStreak);
        }
      };

      ActiveHabit.prototype.increaseStreak = function(prevStk) {
        if (prevStk > 0) {
          return prevStk + 1;
        } else {
          return 1;
        }
      };

      ActiveHabit.prototype.decreaseStreak = function(prevStk) {
        if (prevStk < 0) {
          return prevStk - 1;
        } else {
          return -1;
        }
      };

      ActiveHabit.prototype.doesntExistOnDay = function(daysAgo) {
        return daysAgo >= this.results.length;
      };

      ActiveHabit.prototype.wasActive = function(daysAgo) {
        return daysAgo < this.results.length;
      };

      return ActiveHabit;

    })();
  });

}).call(this);
