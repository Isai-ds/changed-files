import {
  MetadataXMLDefinition,
  MetadataFileResult
} from '../lib/metadataInterfaces'
import {FileCommitted} from '../lib/gitDiffInterfaces'

class InBundleXMLDefinition implements MetadataXMLDefinition {
  getMetadataFileResult(file: FileCommitted): MetadataFileResult {
    throw new Error('Method not implemented.')
  }

  getType(): MetadataXMLDefinition {
    throw new Error('Method not implemented.')
  }
}

export class AuraBundle extends InBundleXMLDefinition {}
export class WebComponent extends InBundleXMLDefinition {}
