import * as variableContext from './variable-context'
import * as GithubAPIHelper from './github-api'
import * as core from '@actions/core'
import {FileCommitted, PullRequestFiles} from './lib/gitDiffInterfaces'

export interface IFileCommitted {
  getAllFiles(): Promise<PullRequestFiles['all']>
}

export function getInstanceFilesCommitted(): IFileCommitted {
  return new FilesCommitted()
}

class FilesCommitted {
  async getAllFiles(): Promise<PullRequestFiles['all']> {
    const base = variableContext.getGithubVariableContext().getBaseRef()['ref']
    const head = variableContext.getGithubVariableContext().getHeadRef()['ref']

    core.info(`Base ref: ${base}`)
    core.info(`Head ref: ${head}`)

    const githubAPIHelper = GithubAPIHelper.getInstance()

    const files = await githubAPIHelper.getFilesInPullRequest(base, head)
    const result = this.build(files)
    return result['all']
  }

  build(files: GithubAPIHelper.DiffEntry): PullRequestFiles {
    const added = [] as FileCommitted[]
    const deleted = [] as FileCommitted[]
    const modified = [] as FileCommitted[]
    const renamed = [] as FileCommitted[]
    const changed = [] as FileCommitted[]

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
        sha: f.sha,
        patch: f.patch
      }
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
