import {FileCommitted} from './gitDiffInterfaces'

export interface MetadataFileResult {
  manifestXML: string
  destructiveXML: string
}

export interface MetadataXMLDefinition {
  getMetadataFileResult(file: FileCommitted): MetadataFileResult
  getType(): MetadataXMLDefinition
}

export interface MetaXMLDefinition {
  getMetaDefinition(): string
}