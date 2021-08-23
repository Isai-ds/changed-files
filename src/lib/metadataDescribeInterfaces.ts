export interface MetadataObject {
  childXmlNames?: string[]
  directoryName: string
  inFolder: boolean
  metaFile: boolean
  suffix?: string
  xmlName: string
}

export interface MetadataDescribe {
  metadataObjects: MetadataObject[]
  organizationNamespace: string
  partialSaveAllowed: boolean
  testRequired: boolean
}