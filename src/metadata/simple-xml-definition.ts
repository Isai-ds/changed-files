import {
  MetadataXMLDefinition,
  MetadataFileResult,
  MetaXMLDefinition
} from '../lib/metadataInterfaces'

import {FileCommitted, GitDiffOperations} from '../lib/gitDiffInterfaces'
import {MetadataObject} from '../lib/metadataDescribeInterfaces'

const METADATA_CHANGE_ADDED = 'added'
const METADATA_CHANGE_CHANGED = 'modified'

export class SimpleXMLDefinition
  implements MetadataXMLDefinition, MetaXMLDefinition {
  protected describeMetadata: MetadataObject
  protected file: FileCommitted
  protected metadataChange: string
  protected xmlMetadataChangesService: XMLMetadataChanges

  constructor(describeMetadata: MetadataObject, file: FileCommitted) {
    this.describeMetadata = describeMetadata
    this.file = file
    this.metadataChange = file.status
    this.xmlMetadataChangesService = new XMLMetadataChanges()
  }

  getMetaDefinition(): string {
    throw new Error('Method not implemented.')
  }

  getMetadataFileResult(): MetadataFileResult {
    switch (this.metadataChange) {
      case METADATA_CHANGE_ADDED:
        break

      case METADATA_CHANGE_CHANGED:
        break
    }

    return {
      xmlName: this.describeMetadata.xmlName,
      manifestXML: '',
      destructiveXML: ''
    }
  }

  getType(): string {
    return this.describeMetadata.xmlName
  }
}

class XMLMetadataChanges implements GitDiffOperations {
  added(): void {
    throw new Error('Method not implemented.')
  }

  modified(): void {
    throw new Error('Method not implemented.')
  }
}
