import * as core from '@actions/core'
import * as fileHelper from './file-helper'
import * as sfdxIntaller from './sfdx-installer'
import * as sfdc from './sfdc-helper'

async function run(): Promise<void> {
  try {
    sfdxIntaller.install()

    const files = await fileHelper.getInstance().getAllFiles()
    core.debug(`${JSON.stringify(files)}`)

    const sfInstance = sfdc.getInstance()
    await sfInstance.login()
    await sfInstance.describeMetadata()
  } catch (error) {
    core.setFailed(error.message)
  }
}

run()
