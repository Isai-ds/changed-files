import * as core from '@actions/core'
import * as GithubAPIHelper from './github-api'
import * as exec from '@actions/exec'

interface File {
  filename: string
  status: string
  sha: string
}
interface Committed {
  added: {
    files: File[]
  }
  modified: {
    files: File[]
  }
  deleted: {
    files: File[]
  }
  renamed: {
    files: File[]
  }
  changed: {
    files: File[]
  }
  all: {
    added: Committed['added']
    deleted: Committed['deleted']
    modified: Committed['modified']
    renamed: Committed['renamed']
    changed: Committed['changed']
  }
}

export interface IFileCommitted {
  getAllFiles(): Promise<Committed['all']>
}

export interface IFileDiff {
  getDifferences(path: string): Promise<string>
}

export function getInstanceFileCommitted(): IFileCommitted {
  return new FileCommitted()
}

export function getInstanceFileDiff(): IFileDiff {
  return new FileDiff()
}

class FileCommitted {
  async getAllFiles(): Promise<Committed['all']> {
    const base = core.getInput('base_ref')
    const head = core.getInput('head_ref')

    core.info(`Base ref: ${base}`)
    core.info(`Head ref: ${head}`)

    const githubAPIHelper = GithubAPIHelper.getInstance()

    const files = await githubAPIHelper.getFilesInPullRequest(base, head)
    const result = this.build(files)
    return result['all']
  }

  build(files: GithubAPIHelper.DiffEntry): Committed {
    const added = [] as File[]
    const deleted = [] as File[]
    const modified = [] as File[]
    const renamed = [] as File[]
    const changed = [] as File[]

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

class FileDiff {
  async getDiffernces(path: string): Promise<string> {
    const difference = await this.getGitDiff(path)
    return difference
  }

  async getGitDiff(path: string): Promise<string> {
    const base = core.getInput('base_ref')
    const head = core.getInput('head_ref')
    const baseHead = `${base}..${head}`

    const parameters = [
      '--no-pager',
      'diff',
      baseHead,
      '--no-prefix',
      '-U200',
      '--',
      path
    ]

    const output = await exec.getExecOutput('sfdx', parameters)
    return output.stdout
  }
}
