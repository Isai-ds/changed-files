import * as core from '@actions/core'
import * as diffGit from './diff-git'
import * as sfdxIntaller from './sfdx-installer'
import * as sfdc from './sfdc-metadata-describe'

async function run(): Promise<void> {
  try {
    await sfdxIntaller.install()

    const gitfiles = await diffGit.getInstanceFileCommitted().getAllFiles()
    core.debug(`${JSON.stringify(gitfiles)}`)

    const fileDiffService = diffGit.getInstanceFileDiff()
    for (const f of gitfiles['modified'].files) {
      const diff = await fileDiffService.getDifferences(f.filename)
      core.info('::::::::::::::::::::::::::::::::::::::::::::::::::::::::')
      core.info(diff)
      core.info('')
    }

    const sfInstance = sfdc.getInstance()
    await sfInstance.login()
    await sfInstance.describeMetadata('directoryName')
  } catch (error) {
    core.setFailed(error.message)
  }
}

run()
