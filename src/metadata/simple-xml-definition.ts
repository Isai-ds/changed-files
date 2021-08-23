import {
  MetadataXMLDefinition,
  MetadataFileResult,
  MetaXMLDefinition
} from '../lib/metadataInterfaces'
import {FileCommitted} from '../lib/gitDiffInterfaces'

export class SimpleXMLDefinition
  implements MetadataXMLDefinition, MetaXMLDefinition {
  getMetaDefinition(): string {
    throw new Error('Method not implemented.')
  }
  getMetadataFileResult(file: FileCommitted): MetadataFileResult {
    throw new Error('Method not implemented.')
  }
  getType(): MetadataXMLDefinition {
    throw new Error('Method not implemented.')
  }
}
