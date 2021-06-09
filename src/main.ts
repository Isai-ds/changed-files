import * as core from '@actions/core'
import * as GithubAPIHelper from './github-api-helper'

async function run(): Promise<void> {
  try {
    const base = core.getInput('base_ref')
    const head = core.getInput('head_ref')

    core.info(`Base ref: ${base}`)
    core.info(`Head ref: ${head}`)

    const githubAPIHelper = GithubAPIHelper.getInstance()

    const files = await githubAPIHelper.getFiles(base, head)
    core.debug(`Response : ${JSON.stringify(files)}`)
  } catch (error) {
    core.setFailed(error.message)
  }
}

run()
