import {
  MetadataXMLDefinition,
  MetadataFileResult
} from '../lib/metadataInterfaces'

class InBundleXMLDefinition implements MetadataXMLDefinition {
  getMetadataFileResult(): MetadataFileResult {
    throw new Error('Method not implemented.')
  }

  getType(): MetadataXMLDefinition {
    throw new Error('Method not implemented.')
  }
}

export class AuraBundle extends InBundleXMLDefinition {}
export class WebComponent extends InBundleXMLDefinition {}
