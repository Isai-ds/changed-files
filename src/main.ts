import * as core from '@actions/core'
import * as fileHelper from './file-helper'

async function run(): Promise<void> {
  try {
    const files = fileHelper.getInstance().getAllFiles()
    core.debug(`${JSON.stringify(files)}`)
  } catch (error) {
    core.setFailed(error.message)
  }
}

run()
