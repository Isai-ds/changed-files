import * as core from '@actions/core'
import * as diffGit from './git-diff'
import * as sfdxIntaller from './sfdx-installer'
import * as sfdc from './sfdc-metadata-describe'

async function run(): Promise<void> {
  try {
    await sfdxIntaller.install()

    const gitfiles = await diffGit.getInstanceFilesCommitted().getAllFiles()
    core.debug(`${JSON.stringify(gitfiles)}`)

    const sfInstance = sfdc.getInstance()
    await sfInstance.login()
    await sfInstance.describeMetadata('directoryName')
  } catch (error) {
    core.setFailed(error.message)
  }
}

run()
