import * as core from '@actions/core'
import * as github from '@actions/github'
import {components} from '@octokit/openapi-types'
import * as variableContext from './variable-context'

export type DiffEntry = components['schemas']['diff-entry'][]
type FileResponse = DiffEntry | undefined

export interface IGitAuthAPI {
  getFilesInPullRequest(base: string, head: string): Promise<DiffEntry>
}

export function getInstance(): IGitAuthAPI {
  return new GitAuthAPI()
}

class GitAuthAPI {
  private octokit

  constructor() {
    const githubToken = variableContext
      .getGithubVariableContext()
      .getGithubToken()
    this.octokit = github.getOctokit(githubToken)
  }

  async getFilesInPullRequest(base: string, head: string): Promise<DiffEntry> {
    const baseHead = `${base}...${head}`
    const result = [] as DiffEntry
    let files = [] as FileResponse

    core.debug(`Build baseHead : ${baseHead}`)
    files = await this.compareCommits(baseHead)

    if (files === undefined) {
      throw new Error(
        `Error getting the files comparing the branches ${baseHead}`
      )
    } else {
      for (const f of files) {
        result.push(f)
      }
    }
    return result
  }

  async compareCommits(baseHead: string): Promise<FileResponse> {
    const response = await this.octokit.rest.repos.compareCommitsWithBasehead({
      owner: github.context.repo.owner,
      repo: github.context.repo.repo,
      basehead: baseHead
    })
    if (response.status !== 200) {
      const errorMessage = `Error comparing the branches ${baseHead}. Response status code: ${response.status}`
      throw new Error(errorMessage)
    }
    return response.data.files
  }
}
