export interface FileCommitted {
  filename: string
  status: string
  sha: string
  patch?: string
}
export interface PullRequestFiles {
  added: {
    files: FileCommitted[]
  }
  modified: {
    files: FileCommitted[]
  }
  deleted: {
    files: FileCommitted[]
  }
  renamed: {
    files: FileCommitted[]
  }
  changed: {
    files: FileCommitted[]
  }
  all: {
    added: PullRequestFiles['added']
    deleted: PullRequestFiles['deleted']
    modified: PullRequestFiles['modified']
    renamed: PullRequestFiles['renamed']
    changed: PullRequestFiles['changed']
  }
}

export interface GitDiffOperations {
  added(): void
  modified(): void
}