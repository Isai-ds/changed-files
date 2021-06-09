import * as core from '@actions/core'
import * as github from '@actions/github'

export interface IGitAuthAPI {
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  compareCommits(base: string, head: string): Promise<void>
}

export function getInstance(): IGitAuthAPI {
  return new GitAuthAPI()
}

class GitAuthAPI {
  private octokit

  constructor() {
    const githubToken = core.getInput('github_token', {required: true})
    this.octokit = github.getOctokit(githubToken)
  }

  async compareCommits(base: string, head: string): Promise<void> {
    const baseHead = `${base}...${head}`
    await this.octokit.rest.repos.compareCommitsWithBasehead({
      owner: github.context.repo.owner,
      repo: github.context.repo.repo,
      basehead: baseHead
    })
  }
}
