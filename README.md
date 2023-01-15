# gh-build-matrix [![demo](https://github.com/bahmutov/gh-build-matrix/actions/workflows/demo.yml/badge.svg?branch=main&event=push)](https://github.com/bahmutov/gh-build-matrix/actions/workflows/demo.yml)
> A little GitHub Action to generate matrix list for other actions to run jobs in parallel

```yml
# in your GitHub Actions workflow
# have a single job "prepare" to build up the matrix
jobs:
  # example splitting all tests across GitHub machines
  prepare:
    runs-on: ubuntu-20.04
    # explicitly set the output of this job
    # so that other jobs can use it
    outputs:
      matrix: ${{ steps.prepare.outputs.matrix }}
    steps:
      - name: Create matrix
        id: prepare
        uses: bahmutov/gh-build-matrix@main
        with:
          n: 3 # number of containers to output
      - name: Print result 🖨
        run: echo '${{ steps.prepare.outputs.matrix }}'
```

When running, it will print something like `{"containers":[1, 2, 3]}`. Then use the output of the `prepare` job in other jobs

```yml
# should run a matrix with 3 jobs
tests:
  needs: prepare
  runs-on: ubuntu-20.04
  strategy:
    fail-fast: false
    matrix: ${{ fromJSON(needs.prepare.outputs.matrix) }}
```

## Examples

- [bahmutov/gh-action-parameter](https://github.com/bahmutov/gh-action-parameter)
- [bahmutov/cypress-workflows](https://github.com/bahmutov/cypress-workflows)

## Development

Read [Creating a Docker container action](https://docs.github.com/en/actions/creating-actions/creating-a-docker-container-action)

## Small print

Author: Gleb Bahmutov &lt;gleb.bahmutov@gmail.com&gt; &copy; 2023

- [@bahmutov](https://twitter.com/bahmutov)
- [glebbahmutov.com](https://glebbahmutov.com)
- [blog](https://glebbahmutov.com/blog)
- [videos](https://www.youtube.com/glebbahmutov)
- [presentations](https://slides.com/bahmutov)
- [cypress.tips](https://cypress.tips)
- [Cypress Tips & Tricks Newsletter](https://cypresstips.substack.com/)
- [my Cypress courses](https://cypress.tips/courses)

License: MIT - do anything with the code, but don't blame me if it does not work.

Support: if you find any problems with this module, email / tweet /
[open issue](https://github.com/bahmutov/gh-build-matrix/issues) on Github

## MIT License

Copyright (c) 2023 Gleb Bahmutov &lt;gleb.bahmutov@gmail.com&gt;

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
