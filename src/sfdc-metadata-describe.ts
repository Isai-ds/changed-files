import * as exec from '@actions/exec'
import * as variableContext from './variable-context'
import {
  MetadataObject,
  MetadataDescribe
} from './lib/metadataDescribeInterfaces'

type metadata = {
  [key: string]: any
}

export interface ISalesforce {
  login(): Promise<void>
  describeMetadata(grouping: string): Promise<Map<string, MetadataObject>>
}

export function getInstance(): ISalesforce {
  return new Salesforce()
}

class Salesforce {
  metadataDescribeResult!: MetadataDescribe

  async login(): Promise<void> {
    const consumerKey = variableContext
      .getSalesforceVariableContext()
      .getConsumerKey()
    const userName = variableContext
      .getSalesforceVariableContext()
      .getUserName()
    const jwtKeyFile = variableContext
      .getSalesforceVariableContext()
      .getJWTKeyFile()
    const instanceUrl = variableContext
      .getSalesforceVariableContext()
      .getInstanceUrl()
    const decryptionKey = variableContext
      .getSalesforceVariableContext()
      .getDecryptionKey()
    const decryptionIV = variableContext
      .getSalesforceVariableContext()
      .getDecryptionIV()

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
      const api_version = variableContext
        .getSalesforceVariableContext()
        .getAPIVersion()
      const parameters = ['force:mdapi:describemetadata', '-u', 'org', '--json']

      if (api_version) {
        parameters.push('--apiversion', api_version)
      }

      const output = await exec.getExecOutput('sfdx', parameters)
      this.metadataDescribeResult = JSON.parse(output.stdout).result
    }
  }

  async describeMetadata(grouping: string): Promise<Map<string, MetadataObject>> {
    const definition = new Map<string, MetadataObject>()
    await this.getDescribeMetadata()

    const describeResult: metadata[] = this.metadataDescribeResult
      .metadataObjects

    for (const item of describeResult) {
      const o = {} as MetadataObject
      o.childXmlNames = item.childXmlNames
      o.directoryName = item.directoryName
      o.inFolder = item.inFolder
      o.metaFile = item.metaFile
      o.suffix = item.suffix
      o.xmlName = item.xmlName
      definition.set(item[grouping], o)
    }
    return definition
  }
}
