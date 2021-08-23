import {
  MetadataXMLDefinition,
  MetadataFileResult,
  MetaXMLDefinition
} from '../lib/metadataInterfaces'

class InFolderXMLDefinition
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

export class Documents extends InFolderXMLDefinition {}
export class Emails extends InFolderXMLDefinition {}
