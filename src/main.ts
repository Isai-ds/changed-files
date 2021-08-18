import * as core from '@actions/core'
import * as fileHelper from './diff-git'
import * as sfdxIntaller from './sfdx-installer'
import * as sfdc from './sfdc-metadata-describe'

async function run(): Promise<void> {
  try {
    await sfdxIntaller.install()

    const files = await fileHelper.getInstance().getAllFiles()
    core.debug(`${JSON.stringify(files)}`)

    const sfInstance = sfdc.getInstance()
    await sfInstance.login()
    await sfInstance.describeMetadata('directoryName')
  } catch (error) {
    core.setFailed(error.message)
  }
}

run()
