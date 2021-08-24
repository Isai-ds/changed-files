import {
  MetadataXMLDefinition,
  MetadataFileResult,
  MetaXMLDefinition
} from '../lib/metadataInterfaces'
import {FileCommitted} from '../lib/gitDiffInterfaces'
import {MetadataObject} from '../lib/metadataDescribeInterfaces'

export class SimpleXMLDefinition
  implements MetadataXMLDefinition, MetaXMLDefinition {
  protected describeMetadata: MetadataObject
  protected file: FileCommitted

  constructor(describeMetadata: MetadataObject, file: FileCommitted) {
    this.describeMetadata = describeMetadata
    this.file = file
  }

  getMetaDefinition(): string {
    throw new Error('Method not implemented.')
  }

  getMetadataFileResult(): MetadataFileResult {
    throw new Error('Method not implemented.')
  }

  getType(): string {
    return this.describeMetadata.xmlName
  }
}
