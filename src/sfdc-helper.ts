import * as core from '@actions/core'
import * as exec from '@actions/exec'
interface metadataObject {
  childXmlNames?: string[]
  directoryName: string
  inFolder: boolean
  metaFile: boolean
  suffix?: string
  xmlName: string
}
interface metadata {
  metadataObjects: metadataObject[]
  organizationNamespace: string
  partialSaveAllowed: boolean
  testRequired: boolean
}

export interface ISalesforce {
  login(): Promise<void>
  describeMetadata(): Promise<metadata>
}

export function getInstance(): ISalesforce {
  return new Salesforce()
}

class Salesforce {
  async login(): Promise<void> {
    const consumerKey = core.getInput('client_id')
    const userName = core.getInput('user_name')
    const jwtKeyFile = core.getInput('jwt_key_file')
    const instanceUrl = core.getInput('instance_url')
    const decryptionKey = core.getInput('decryption_key')
    const decryptionIV = core.getInput('decryption_iv')

    await exec.exec('openssl', [
      'enc',
      '-nosalt',
      '-aes-256-cbc',
      '-d',
      '-in',
      jwtKeyFile,
      '-out',
      'server.key',
      '-base64',
      '-K',
      decryptionKey,
      '-iv',
      decryptionIV
    ])

    await exec.exec('sfdx', [
      'force:auth:jwt:grant',
      '--instanceurl',
      instanceUrl,
      '--clientid',
      consumerKey,
      '--jwtkeyfile',
      'server.key',
      '--username',
      userName,
      '--setalias',
      'org'
    ])
  }

  async describeMetadata(): Promise<metadata> {
    const result = {} as metadata
    const output = await exec.getExecOutput('sfdx', [
      'force:mdapi:describemetadata',
      '-u',
      'org',
      '--json'
    ])
    core.debug(`Output ${JSON.stringify(output)}`)
    return result
  }
}
