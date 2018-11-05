const minimist = require('minimist')
const fs = require('fs')
const path = require('path')
const args = minimist(process.argv.slice(2), {
  alias: {
    messagePath: ['p'],
    authorsPath: ['a']
  },
  default: {
    messagePath: '.git/COMMIT_EDITMSG',
    authorsPath: 'AUTHORS'
  }
})

const messagePath = path.resolve(args.messagePath)
const authorsPath = path.resolve(args.authorsPath)

type Author = {
  name: string,
  email: string,
  website?: string
}

type GitAuthor = {
  name: string,
  email: string
}

const parseAuthor = (line: string): Author => {
  const [, name, email, , website]: string[] = (
    /(.+) <(.+)>( \((.+)\))?/.exec(line) || []
  )

  return {
    name,
    email,
    website
  }
}

const stringifyAuthor = (author: Author): string => {
  const parts = [
    `${author.name}`,
    `<${author.email}>`
  ]
  if (author.website) {
    parts.push(`(${author.website})`)
  }
  return parts.join(' ')
}

const getAuthors = (p: string) => (
  fs.readFileSync(p)
    .toString()
    .split('\n')
    .map((line: string) => line.trim())
    .map((line: string) => parseAuthor(line))
)

let content = fs.readFileSync(messagePath).toString()

fs.writeFileSync(messagePath, content)
