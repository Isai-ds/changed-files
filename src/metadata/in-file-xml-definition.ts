import {
  MetadataXMLDefinition,
  MetadataFileResult
} from '../lib/metadataInterfaces'

class InFileXMLDefinition implements MetadataXMLDefinition {
  getMetadataFileResult(): MetadataFileResult {
    throw new Error('Method not implemented.')
  }
  getType(): MetadataXMLDefinition {
    throw new Error('Method not implemented.')
  }
}

export class CustomObject extends InFileXMLDefinition {}
export class Label extends InFileXMLDefinition {}
export class Profile extends InFileXMLDefinition {}
export class SharingRules extends InFileXMLDefinition {}
