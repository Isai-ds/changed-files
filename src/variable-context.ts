import * as core from '@actions/core'

interface GithubContext {
  [key: string]: any
}

interface IGithubVariableContext {
  getGithubToken(): string
  getBaseRef(): GithubContext
  getHeadRef(): GithubContext
}

interface ISalesforceVariableContext {
  getConsumerKey(): string
  getUserName(): string
  getJWTKeyFile(): string
  getInstanceUrl(): string
  getDecryptionKey(): string
  getDecryptionIV(): string
  getAPIVersion(): string
}

let githubVariableContext: IGithubVariableContext
let salesforceVariableContext: ISalesforceVariableContext

export function getGithubVariableContext(): IGithubVariableContext {
  if (!githubVariableContext) {
    githubVariableContext = new GithubVariableContext()
  }
  return githubVariableContext
}

export function getSalesforceVariableContext(): ISalesforceVariableContext {
  if (!salesforceVariableContext) {
    salesforceVariableContext = new SalesforceVariableContext()
  }
  return salesforceVariableContext
}

class GithubVariableContext {
  getGithubToken(): string {
    return core.getInput('github_token', {required: true})
  }

  getBaseRef(): GithubContext {
    return JSON.parse(core.getInput('base_ref')) as GithubContext
  }

  getHeadRef(): GithubContext {
    return JSON.parse(core.getInput('head_ref')) as GithubContext
  }
}

class SalesforceVariableContext {
  getConsumerKey(): string {
    return core.getInput('client_id')
  }

  getUserName(): string {
    return core.getInput('user_name')
  }

  getJWTKeyFile(): string {
    return core.getInput('jwt_key_file')
  }

  getInstanceUrl(): string {
    return core.getInput('instance_url')
  }

  getDecryptionKey(): string {
    return core.getInput('decryption_key')
  }

  getDecryptionIV(): string {
    return core.getInput('decryption_iv')
  }
  getAPIVersion(): string {
    return core.getInput('api_version')
  }
}
