import {
  MetadataXMLDefinition,
  MetadataFileResult
} from '../lib/metadataInterfaces'
import {FileCommitted} from '../lib/gitDiffInterfaces'
import {MetadataObject} from '../lib/metadataDescribeInterfaces'

class InFileXMLDefinition implements MetadataXMLDefinition {
  protected describeMetadata: MetadataObject
  protected file: FileCommitted

  constructor(describeMetadata: MetadataObject, file: FileCommitted) {
    this.describeMetadata = describeMetadata
    this.file = file
  }

  getMetadataFileResult(): MetadataFileResult {
    throw new Error('Method not implemented.')
  }

  getType(): string {
    return this.describeMetadata.xmlName
  }
}

export class CustomObject extends InFileXMLDefinition {}
export class CustomLabel extends InFileXMLDefinition {}
export class Profile extends InFileXMLDefinition {}
export class SharingRule extends InFileXMLDefinition {}
