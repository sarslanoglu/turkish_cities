# Contributing

If you discover issues, have ideas for improvements or new features,
please report them to the [issue tracker][1] of the repository or
submit a pull request. Please, try to follow these guidelines when you
do so.

## Guidelines

* Read [how to properly contribute to open source projects on GitHub][2].
* Fork the project.
* Write [good commit messages][3].
* Use the same coding conventions as the rest of the project.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it.
* Add an entry to the [Changelog](CHANGELOG.md) accordingly. See [changelog entry format](#changelog-entry-format).
* Make sure the test suite is passing and the code you wrote doesn't produce RuboCop offenses.
* [Squash related commits together][4].

### Changelog entry format

Here are a few examples:

```
* [#11](https://github.com/sarslanoglu/turkish_cities/pull/11): Change city_list data to yaml file format
* [#6](https://github.com/sarslanoglu/turkish_cities/pull/6): Fix capital Turkish characters bug on cities with capital 'I' letter
* [#16](https://github.com/sarslanoglu/turkish_cities/pull/16): Handle error messages at ```find_name_by_plate_number``` and ```find_plate_number_by_name``` methods
```

* Mark it up in [Markdown syntax][5].
* The entry line should start with `* ` (an asterisk and a space).
* If the change has a related GitHub issue (e.g. a bug fix for a reported issue), put a link to the issue as `[#11](https://github.com/sarslanoglu/turkish_cities/issues/11): `.

[1]: https://github.com/sarslanoglu/turkish_cities/issues
[2]: https://www.gun.io/blog/how-to-github-fork-branch-and-pull-request
[3]: https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
[4]: http://gitready.com/advanced/2009/02/10/squashing-commits-with-rebase.html
[5]: https://daringfireball.net/projects/markdown/syntax