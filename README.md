# plus-typescript

This is a fork of [TypeScript](https://www.typescriptlang.org/), including a 30 line hack to allow  type annotations ***using comments*** in the code.

If you enclose all ts-specific code inside comments, the .ts source file becomes ***directly*** executable by node and the browser without the need of a transpilation step.

Then, you can directly edit sources on Chrome Developer Tools with hot-reload and instant feedback. Chrome Developer Tools also allows you to map a local folder so you can save your changes using Chrome Developer Tools as a fast-and-dirty IDE.

We wanted all of this without losing the amazing productivity TypeScript brings in, so this hack was born to allow us to ***run the sources, avoid the transpilation step but keep using TypeScript***.

## Examples

TypeScript: type-checked, needs transpiling step
```typescript
export function 
  ShowHelp(title:string, options:Record<string,OptDecl>):void{
    // show help about declared options
    console.log("-".repeat(60))
    console.log("Options:")
...
}
```

plus-typescript, type-checked, can be run by node or the browser
```typescript
export function 
  ShowHelp(title/*:string*/, options/*:Record<string,OptDecl>*/) /*:void*/ {
    // show help about declared options
    console.log("-".repeat(60))
    console.log("Options:")
...
}
```

## How it works

The 30-line hack inside TypeScript infraestructure services makes the following sequences invisible to tsc:

* `/*:` and `*/` when used on the same line, so you can write `title/*:string*/` and tsc will see: `title:string`

* `/*+` and `+*/` `slash-asterisk-plus` and `plus-asterisk-slash`, are invisble to tsc


### slash-asterisk-plus examples

```typescript
//util/CommandLineArgs.ts
/*+
export type OptionDeclaration =
    {
        shortName: string
        valueType?: string
        helpText?: string
        value?: string|number|boolean
    }
+*/

//main.ts
/*+import { OptionDeclaration } from "./util/CommandLineArgs"+*/
```
```typescript
function view(command/*:string*/, fnJSONparams/*+?:any+*/)/*:string*/ {...
```
<small>*Here the annotation `?:any` is processed by typescript but ignored by node and the browser*</small>

## Usage

`npm install --save-dev plus-typescript`
`npm remove typescript`

* Keep the .ts extension on the source files
* add `"plus-typescript"` instead of `"typescript"` in your package.json's `"devDependencies:{"` 
* move all ts type-annotations inside comments `/*:` or `/*+`
* use the .ts files directly with node or in the browser 

See the example project for a complete package.json example

## Example project

**plus-ts-test** is a project example using `plus-typescript` and node v14 to make a CLI tool, you can see the project here: [github.com/luciotato/plus-ts-test](github.com/luciotato/plus-ts-test)

### Running .ts files directly with node

You keep the .ts extension for the source files. The browser has no problem importing a script ending in .ts, but node will complain. If you're writing a console app in node, you'll have to use a loader-hook to convince node to accept .ts files as .js type:"module" files. All this is solved in the example project above.

## Status
This is beta and barely tested. Mantainers and contributors are welcomed.

## Contibuting
The modifications are in the `plus` branch, and that's the brach that's published in npm as `plus-typescript`. 

The `master` branch will be kept up-to-date from the official TypeScript repository.

We're keeping the same version number as TypeScript

Besides the hack, `plus-typescript` is completely API-compatible with TypeScript.


--------------


# TypeScript

[![Build Status](https://travis-ci.org/microsoft/TypeScript.svg?branch=master)](https://travis-ci.org/microsoft/TypeScript)
[![Devops Build Status](https://dev.azure.com/typescript/TypeScript/_apis/build/status/Typescript/node10)](https://dev.azure.com/typescript/TypeScript/_build?definitionId=7)
[![npm version](https://badge.fury.io/js/typescript.svg)](https://www.npmjs.com/package/typescript)
[![Downloads](https://img.shields.io/npm/dm/typescript.svg)](https://www.npmjs.com/package/typescript)

[TypeScript](https://www.typescriptlang.org/) is a language for application-scale JavaScript. TypeScript adds optional types to JavaScript that support tools for large-scale JavaScript applications for any browser, for any host, on any OS. TypeScript compiles to readable, standards-based JavaScript. Try it out at the [playground](https://www.typescriptlang.org/play/), and stay up to date via [our blog](https://blogs.msdn.microsoft.com/typescript) and [Twitter account](https://twitter.com/typescript).

Find others who are using TypeScript at [our community page](https://www.typescriptlang.org/community/).

## Installing

For the latest stable version:

```bash
npm install -g typescript
```

For our nightly builds:

```bash
npm install -g typescript@next
```

## Contribute

There are many ways to [contribute](https://github.com/microsoft/TypeScript/blob/master/CONTRIBUTING.md) to TypeScript.
* [Submit bugs](https://github.com/microsoft/TypeScript/issues) and help us verify fixes as they are checked in.
* Review the [source code changes](https://github.com/microsoft/TypeScript/pulls).
* Engage with other TypeScript users and developers on [StackOverflow](https://stackoverflow.com/questions/tagged/typescript).
* Help each other in the [TypeScript Community Discord](https://discord.gg/typescript).
* Join the [#typescript](https://twitter.com/search?q=%23TypeScript) discussion on Twitter.
* [Contribute bug fixes](https://github.com/microsoft/TypeScript/blob/master/CONTRIBUTING.md).
* Read the archived language specification ([docx](https://github.com/microsoft/TypeScript/blob/master/doc/TypeScript%20Language%20Specification%20-%20ARCHIVED.docx?raw=true),
 [pdf](https://github.com/microsoft/TypeScript/blob/master/doc/TypeScript%20Language%20Specification%20-%20ARCHIVED.pdf?raw=true), [md](https://github.com/microsoft/TypeScript/blob/master/doc/spec-archived.md)).

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see
the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com)
with any additional questions or comments.

## Documentation

*  [TypeScript in 5 minutes](https://www.typescriptlang.org/docs/handbook/typescript-in-5-minutes.html)
*  [Programming handbook](https://www.typescriptlang.org/docs/handbook/basic-types.html)
*  [Homepage](https://www.typescriptlang.org/)

## Building

In order to build the TypeScript compiler, ensure that you have [Git](https://git-scm.com/downloads) and [Node.js](https://nodejs.org/) installed.

Clone a copy of the repo:

```bash
git clone https://github.com/microsoft/TypeScript.git
```

Change to the TypeScript directory:

```bash
cd TypeScript
```

Install [Gulp](https://gulpjs.com/) tools and dev dependencies:

```bash
npm install -g gulp
npm ci
```

Use one of the following to build and test:

```
gulp local             # Build the compiler into built/local.
gulp clean             # Delete the built compiler.
gulp LKG               # Replace the last known good with the built one.
                       # Bootstrapping step to be executed when the built compiler reaches a stable state.
gulp tests             # Build the test infrastructure using the built compiler.
gulp runtests          # Run tests using the built compiler and test infrastructure.
                       # Some low-value tests are skipped when not on a CI machine - you can use the
                       # --skipPercent=0 command to override this behavior and run all tests locally.
                       # You can override the specific suite runner used or specify a test for this command.
                       # Use --tests=<testPath> for a specific test and/or --runner=<runnerName> for a specific suite.
                       # Valid runners include conformance, compiler, fourslash, project, user, and docker
                       # The user and docker runners are extended test suite runners - the user runner
                       # works on disk in the tests/cases/user directory, while the docker runner works in containers.
                       # You'll need to have the docker executable in your system path for the docker runner to work.
gulp runtests-parallel # Like runtests, but split across multiple threads. Uses a number of threads equal to the system
                       # core count by default. Use --workers=<number> to adjust this.
gulp baseline-accept   # This replaces the baseline test results with the results obtained from gulp runtests.
gulp lint              # Runs eslint on the TypeScript source.
gulp help              # List the above commands.
```


## Usage

```bash
node built/local/tsc.js hello.ts
```


## Roadmap

For details on our planned features and future direction please refer to our [roadmap](https://github.com/microsoft/TypeScript/wiki/Roadmap).
