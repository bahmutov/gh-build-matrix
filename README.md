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

## Development

Read [Creating a Docker container action](https://docs.github.com/en/actions/creating-actions/creating-a-docker-container-action)
