export interface MetadataFileResult {
  manifestXML: string
  destructiveXML: string
}

export interface MetadataXMLDefinition {
  getMetadataFileResult(): MetadataFileResult
  getType(): MetadataXMLDefinition
}

export interface MetaXMLDefinition {
  getMetaDefinition(): string
}