import * as core from '@actions/core'
import * as GithubAPIHelper from './github-api-helper'

interface file {
  filename: string
  status: string
  sha: string
}
interface commited {
  added: {
    files: file[]
  }
  modified: {
    files: file[]
  }
  deleted: {
    files: file[]
  }
  renamed: {
    files: file[]
  }
  changed: {
    files: file[]
  }
  all: {
    added: commited['added']
    deleted: commited['deleted']
    modified: commited['modified']
    renamed: commited['renamed']
    changed: commited['changed']
  }
}

export interface IFileCommited {
  getAllFiles(): Promise<commited['all']>
}

export function getInstance(): IFileCommited {
  return new FileCommited()
}

class FileCommited {
  async getAllFiles(): Promise<commited['all']> {
    const base = core.getInput('base_ref')
    const head = core.getInput('head_ref')

    core.info(`Base ref: ${base}`)
    core.info(`Head ref: ${head}`)

    const githubAPIHelper = GithubAPIHelper.getInstance()

    const files = await githubAPIHelper.getFilesInPullRequest(base, head)
    const result = this.build(files)
    return result['all']
  }

  build(files: GithubAPIHelper.DiffEntry): commited {
    const added = [] as file[]
    const deleted = [] as file[]
    const modified = [] as file[]
    const renamed = [] as file[]
    const changed = [] as file[]

    const result = {
      added: {
        files: added
      },
      deleted: {
        files: deleted
      },
      modified: {
        files: modified
      },
      renamed: {
        files: renamed
      },
      changed: {
        files: changed
      },
      all: {
        added: {
          files: added
        },
        deleted: {
          files: changed
        },
        modified: {
          files: modified
        },
        renamed: {
          files: renamed
        },
        changed: {
          files: changed
        }
      }
    }

    for (const f of files) {
      const fc = {
        filename: f.filename,
        status: f.status,
        sha: f.sha
      }
      core.debug(`File commited: ${fc}`)
      switch (f.status) {
        case 'added':
          result['added']['files'].push(fc)
          break
        case 'deleted':
          result['deleted']['files'].push(fc)
          break
        case 'modified':
          result['modified']['files'].push(fc)
          break
        case 'renamed':
          result['renamed']['files'].push(fc)
          break
        case 'changed':
          result['changed']['files'].push(fc)
          break
        default:
          core.debug(
            `The file ${f.filename} has a non status supported '${f.status}'`
          )
      }
    }
    return result
  }
}
