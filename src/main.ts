import * as core from '@actions/core'
import * as fileHelper from './file-helper'
import {AuthInfo, Connection} from '@salesforce/core'
import * as exec from '@actions/exec'
import * as fs from 'fs'

async function run(): Promise<void> {
  try {
    const files = await fileHelper.getInstance().getAllFiles()
    core.debug(`${JSON.stringify(files)}`)

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
    const privateServerKey = await fs.promises.readFile(
      jwtKeyFile.split('/')[0].concat('/'),
      'utf-8'
    )
    core.info(`Server key ${privateServerKey}`)
    const authInfo = await AuthInfo.create({
      username: userName,
      oauth2Options: {
        loginUrl: instanceUrl,
        clientId: consumerKey,
        privateKeyFile: privateServerKey
      }
    })
    const connection = await Connection.create({authInfo})
    const sObjectResult = await connection.describe('Account')

    core.info(`Server key ${sObjectResult.name}`)
  } catch (error) {
    core.setFailed(error.message)
  }
}

run()
