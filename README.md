---
layout: page_github_repo
title: "Gaussian Tools"
github_repo: gaussian-tools
author: Chauncey Garrett
published: true
date:
updated:
noindex: false
permalink: /projects/gaussian-tools/
external-url:
tags:
- gaussian
- github
- zsh
- python
- chemistry
- awk
- sed
- excel
- quantum
category: project
description: Useful input/output tools written for Gaussian (an electronic structure program for computational chemistry).
keywords: TODO
sharing: true
comments: false
footer: true
---

* Table of Contents placeholder (via kramdown)
{:toc}

# Useful input/output tools written for [Gaussian](http://www.gaussian.com "Gaussian")[^gaussian]

[^gaussian]: an electronic structure program for computational chemistry

These tools work for me; they may not work for you. Since using this scripts can have a HUGE impact on your research, I suggest you have a look at each of them to full understand their implications to your work flow. That being said, I personally use them and have tested them to the best of my ability/experience. Of course, if you find a better way to do things then by all means share by opening an [issue!](https://github.com/chauncey-garrett/gaussian-tools/issues "chauncey-garrett/gaussian-tools/issues") My hope is to learn a good bit of coding as I make these scripts. I currently use them to extract data from output files and to tweak input files of larger jobs.

These scripts may be used individually or with one another. For example, if you are interested in the lowest imaginary frequency, you would run

```sh
g09-lowest-imaginary-frequency.zsh "foo.out"
```

and the pertinent data point would be output to the command line. Alternatively, if you wish to aggregate data into a `csv` file for further analysis with a spreadsheet program you could utilize several of the scripts together (for an example of how to integrate the individual scripts with one another, see `g09-make-data` and `g09-generate-supporting-information`). All scripts generally work in format of

```sh
g09-foo.zsh "foo.out"
```

with the exception of `g09-mulliken-charges.zsh`, which can take a second argument of the atom whose Mulliken charge you wish to grab specifically.

# Tools

| Command                                           | Description
| -----------                                       | -----------
| `g09-cartesians`                                  | XYZ cartesian coordinates of converged geometry
| `g09-check-point-file-name`                       | Check point file name
| `g09-converged-point-group`                       | Full point group
| `g09-data-test`                                   | Used to format the null result of each of these tests
| `g09-electronic-energy-after-SDF-is-done`         | Electronic energy after SDF is done
| `g09-generate-supporting-information`             | Generation of supporting information into a hybrid HTML/MultMarkdown document
| `g09-lowest-imaginary-frequency`                  | Lowest converged imaginary frequency
| `g09-make-data`                                   | Generation of all of this information into a `csv` file for further analysis
| `g09-mean-of-alpha-and-beta-electrons`            | Mean of the alpha and beta electrons
| `g09-mulliken-charges`                            | Grab the Mulliken charges of a molecule
| `g09-mm-sanity-check--sum-of-all-charges`         | Molecular Mechanics sanity Check: sum of all charges
| `g09-mm-sanity-check--sum-of-atom-charges`        | Molecular Mechanics sanity Check: sum of all atom charges
| `g09-number-of-basis-functions`                   | Number of basis functions
| `g09-number-of-imaginary-frequencies`             | Number of imaginary frequencies in converged geometry
| `g09-oniom-extrapolated-energy`                   | ONIOM extrapolated energy
| `g09-organize-data`                               | Organize the completed jobs on a server into those that terminated correctly and those that haven't
| `g09-revision`                                    | Grab the revision of Gaussian used to run the job
| `g09-route-section`                               | Route information of input file
| `g09-spin-contamination-after-annihilation`       | Spin contamination after annihilation
| `g09-spin-contamination-before-annihilation`      | Spin contamination before annihilation
| `g09-stoichiometry`                               | Stoichiometry
| `g09-sum-of-electronic-and-thermal-energies`      | Sum of electronic and thermal energies
| `g09-sum-of-electronic-and-thermal-enthalpies`    | Sum of electronic and thermal enthalpies
| `g09-sum-of-electronic-and-thermal-free-energies` | Sum of electronic and thermal free energies
| `g09-sum-of-electronic-and-zero-point-energies`   | Sum of electronic and zero-point energies
| `g09-title-card`                                  | Title Card of input file

# Compatibility

I typically stay on the bleeding edge of computing. I created these on OS X 10.9 and have tested them using the following:

| Program  | Version
| ---      | ---
| zsh      | >= 5.0.2
| python   | == 2.7.5
| GNU awk  | >= 4.1.0
| Gaussian | == Gaussian 09, Revision C.01 (there is β support for Rev.  D.01)

# Future work

There are currently plans to incorporate the above abilities to output from the `formchk` utility Gaussian provides. The rationale is that the output from that utility will not change between revisions of Gaussian, making the scripts far more reliable, faster to use and easier to maintain.

# Like it?

Add it to your toolbox; If not, open an [issue!](https://github.com/chauncey-garrett/gaussian-tools/issues "chauncey-garrett/gaussian-tools/issues")

# Author(s)

*The author(s) of this toolset should be contacted via the [issue tracker](https://github.com/chauncey-garrett/gaussian-tools/issues "chauncey-garrett/gaussian-tools/issues").*

  - [Chauncey Garrett](https://github.com/chauncey-garrett "chauncey-garrett")

[![](/img/tip.gif)](http://chauncey.io/about/index.html#tip)
