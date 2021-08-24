import {
  MetadataXMLDefinition,
  MetadataFileResult
} from '../lib/metadataInterfaces'
import {FileCommitted} from '../lib/gitDiffInterfaces'
import {MetadataObject} from '../lib/metadataDescribeInterfaces'

class InBundleXMLDefinition implements MetadataXMLDefinition {
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

export class AuraDefinitionBundle extends InBundleXMLDefinition {}
export class LightningComponentBundle extends InBundleXMLDefinition {}
