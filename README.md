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


