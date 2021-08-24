import {FileCommitted} from './gitDiffInterfaces'

export interface MetadataFileResult {
  manifestXML: string
  destructiveXML: string
}

export interface MetadataXMLDefinition {
  getMetadataFileResult(): MetadataFileResult
  getType(): string
}

export interface MetaXMLDefinition {
  getMetaDefinition(): string
}