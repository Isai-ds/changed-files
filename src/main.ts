import * as core from '@actions/core'
import * as GithubAPIHelper from './github-api-helper'

async function run(): Promise<void> {
  try {
    const base = core.getInput('base_ref')
    const head = core.getInput('head_ref')

    core.info(`Base ref: ${base}`)
    core.info(`Head ref: ${head}`)

    const githubAPIHelper = GithubAPIHelper.getInstance()

    const response = await githubAPIHelper.compareCommits(base, head)
    core.debug(`Response : ${response}`)
  } catch (error) {
    core.setFailed(error.message)
  }
}

run()
