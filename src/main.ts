import * as core from '@actions/core'
import * as diffGit from './git-diff'
import * as sfdxIntaller from './sfdx-installer'
import * as sfdc from './sfdc-metadata-describe'
import * as metadataFileManager from './metadata-file-manager'
async function run(): Promise<void> {
  try {
    await sfdxIntaller.install()

    const gitFiles = await diffGit.getInstanceFilesCommitted().getAllFiles()

    const sfInstance = sfdc.getInstance()
    await sfInstance.login()
    const metadataDescribe = await sfInstance.describeMetadata('directoryName')
    const metadataXMLDefinition = metadataFileManager.execute(
      gitFiles,
      metadataDescribe
    )

    for (const m of metadataXMLDefinition) {
      core.info(String(m.getType()))
    }
  } catch (error) {
    core.setFailed(error.message)
  }
}

run()
