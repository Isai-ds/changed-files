import {
  MetadataXMLDefinition,
  MetadataFileResult,
  MetaXMLDefinition
} from '../lib/metadataInterfaces'

export class SimpleXMLDefinition
  implements MetadataXMLDefinition, MetaXMLDefinition {
  getMetaDefinition(): string {
    throw new Error('Method not implemented.')
  }
  getMetadataFileResult(): MetadataFileResult {
    throw new Error('Method not implemented.')
  }
  getType(): MetadataXMLDefinition {
    throw new Error('Method not implemented.')
  }
}
