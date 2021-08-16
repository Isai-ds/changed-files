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

type metadata = {
  [key: string]: metadataObject
}

interface metadataDescribe {
  metadataObjects: metadataObject[]
  organizationNamespace: string
  partialSaveAllowed: boolean
  testRequired: boolean
}

export interface ISalesforce {
  login(): Promise<void>
  describeMetadata(grouping: string): Promise<Map<string, metadataObject>>
}

export function getInstance(): ISalesforce {
  return new Salesforce()
}

class Salesforce {
  metadataDescribeResult!: metadataDescribe

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

  private async getDescribeMetadata(): Promise<void> {
    if (!this.metadataDescribeResult) {
      const output = await exec.getExecOutput('sfdx', [
        'force:mdapi:describemetadata',
        '-u',
        'org',
        '--json'
      ])
      this.metadataDescribeResult = JSON.parse(output.stdout).result
    }
  }

  async describeMetadata(grouping: string): Promise<Map<string, metadataObject>> {
    const definition = new Map<string, metadataObject>()
    await this.getDescribeMetadata()

    type meta = {
      [key: string]: any
    }

    const describeResult: meta[] = this.metadataDescribeResult.metadataObjects
    for (const item of describeResult) {
      definition.set(grouping, item[grouping])
    }
    /*const r = definition.reduce((m: metadata, describe: metadata): metadata => {
      m[describe[grouping]] = describe
      return m
    }, {})
    core.info(`${JSON.stringify(r)}`)
    core.info(`${JSON.stringify(r['classes'].inFolder)}`)
    */
    core.info(`${JSON.stringify(definition.get('classes'))}`)
    return definition
  }
}
