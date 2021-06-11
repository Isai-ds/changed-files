import * as core from '@actions/core'
import * as exec from '@actions/exec'
//Getting the code from https://github.com/tiagonnascimento/sfdx-orgdev-build-deploy/blob/master/src/utils/install-dependencies.js
export async function install(): Promise<void> {
  core.info('::::::::::::::Installing SFDX::::::::::::::')

  await exec.exec('wget', [
    'https://developer.salesforce.com/media/salesforce-cli/sfdx-linux-amd64.tar.xz'
  ])
  await exec.exec('mkdir', ['-p', 'sfdx-cli'])
  await exec.exec('tar', [
    'xJf',
    'sfdx-linux-amd64.tar.xz',
    '-C',
    'sfdx-cli',
    '--strip-components',
    '1'
  ])
  await exec.exec('./sfdx-cli/install', [])
  core.info('::::::::::::::SFDX isntalled::::::::::::::')
}
