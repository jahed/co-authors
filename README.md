# @jahed/co-authors

Add Co-Authors to a commit message automatically.

[![Travis](https://img.shields.io/travis/jahed/promises.svg)](https://travis-ci.org/jahed/promises)
[![npm](https://img.shields.io/npm/v/@jahed/promises.svg)](https://www.npmjs.com/package/@jahed/promises)
[![Patreon](https://img.shields.io/badge/patreon-donate-f96854.svg)](https://www.patreon.com/jahed)

## Installation

### 1. Add the module to your project

```bash
# Yarn
yarn add @jahed/co-authors

# NPM
npm install @jahed/co-authors
```

### 2. Install Git Hook

```json
{
  // ...
  "husky": {
    "hooks": {
      "commit-msg": "co-authors -m $HUSKY_GIT_PARAMS"
    }
  }
  // ...
}
```


## Usage



## License

[MIT](LICENSE)
